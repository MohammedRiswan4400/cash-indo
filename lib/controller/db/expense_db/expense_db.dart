import 'dart:developer';

import 'package:cash_indo/controller/db/user_db/user_db.dart';
import 'package:cash_indo/core/formats/formats_functions.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/model/expense_model.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/expanses/category/category_bloc.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/expanses/date/by_date_bloc.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/expanses/highest_expense/highest_expense_bloc.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/expanses/weekly_chart/weekly_expense_chart_bloc.dart';
import 'package:cash_indo/widget/expansion_tile.dart';
import 'package:cash_indo/widget/helper/dialoge_helper_widget.dart';
import 'package:cash_indo/widget/helper/snack_bar_helper_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExpenseDb {
  static final dataBase = Supabase.instance.client.from('expense');

  //write
  static Future<void> addExpense(
      {required ExpenseModel expenseModel,
      required BuildContext context}) async {
    try {
      DailogHelper.showDailog('Saving ...');
      final String uID = UserDb.supaUID;

      if (uID.isEmpty) {
        throw Exception("User is not authenticated.");
      }

      final response = await dataBase.insert({
        'user_id': uID,
        'year': AppFormats.yearFormattedDate(DateTime.now()),
        'month': AppFormats.monthFormattedDate(DateTime.now()),
        'today': AppFormats.barFormattedDate(DateTime.now()),
        'category': expenseModel.category,
        'amount': expenseModel.amount,
        'comment': expenseModel.comment,
        'payment_methode': expenseModel.paymentMethode,
        'currency': expenseModel.currency,
        'created_at': DateTime.now().toIso8601String(),
      }).select();

      DailogHelper.hideDailoge();
      AppRoutes.popNow();
      ExpenseDb.fetchExpense(
          // ignore: use_build_context_synchronously
          context,
          AppFormats.monthFormattedDate(DateTime.now()));
      if (response.isNotEmpty) {
        SnackBarHelper.snackBarSuccess(
          'Succesfull',
          'Expense added succesfull',
        );
      } else {
        throw Exception("Failed to save Expense.");
      }
    } on AuthException catch (e) {
      DailogHelper.hideDailoge();
      SnackBarHelper.snackBarFaild('Oops!', e.message);
      log('Auth Error: ${e.message}');
    } catch (e) {
      DailogHelper.hideDailoge();
      final errorMessage = e is Exception
          ? e.toString().replaceAll("Exception: ", "")
          : "An unexpected error occurred.";
      log('Error: $e');
      SnackBarHelper.snackBarFaild('Oops!', errorMessage);
    }
  }

  //read
  static Future<List<List<ExpenseModel>>> readExpense(String month) async {
    final userID = UserDb.supaUID;

    try {
      final data =
          await dataBase.select('*').eq('user_id', userID).eq('month', month);

      final groupedData = <String, List<ExpenseModel>>{};
      for (var expense in data) {
        final expenseModel = ExpenseModel.fromMap(expense);
        final todayDate = expense['today'] as String?;

        if (todayDate != null) {
          if (!groupedData.containsKey(todayDate)) {
            groupedData[todayDate] = [];
          }
          groupedData[todayDate]!.add(expenseModel);
        }
      }
      return groupedData.values.toList();
    } catch (e) {
      log("Error fetching monthly expense for $month: $e");
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getMonthlyExpenseByCategory(
      String month) async {
    final userID = UserDb.supaUID;

    try {
      final response = await dataBase
          .select('category, amount')
          .eq('user_id', userID)
          .eq('month', month);

      if (response.isEmpty) {
        return [];
      }

      // Create a map to store category-wise total
      Map<String, double> categoryTotals = {};

      for (var record in response) {
        String category = record['category'];
        double amount = (record['amount'] as num).toDouble();

        // Add amount to the category's total
        if (categoryTotals.containsKey(category)) {
          categoryTotals[category] = categoryTotals[category]! + amount;
        } else {
          categoryTotals[category] = amount;
        }
      }

      // Convert map to a list of {category, total}
      List<Map<String, dynamic>> categoryList = categoryTotals.entries
          .map((entry) => {'category': entry.key, 'total': entry.value})
          .toList();

      return categoryList;
    } catch (e) {
      log("Error fetching monthly income by category for $month: $e");
      return [];
    }
  }

  static Future<List<BarChartGroupData>> readWeaklyExpenseChartData(
      String month) async {
    final userID = UserDb.supaUID; // Assuming you have user authentication

    try {
      final response = await dataBase
          .select('today, amount') // Select today and amount fields
          .eq('user_id', userID)
          .eq('month', month)
          .order('today', ascending: true); // Order by date

      if (response.isEmpty) {
        return [];
      }

      // ✅ Map of total expenses per weekday (Sun - Sat)
      Map<String, double> weeklyTotals = {
        "Sun": 0.0,
        "Mon": 0.0,
        "Tue": 0.0,
        "Wed": 0.0,
        "Thu": 0.0,
        "Fri": 0.0,
        "Sat": 0.0
      };

      for (var expense in response) {
        final String today = expense['today'];
        final double amount = (expense['amount'] as num).toDouble();

        DateTime date = DateFormat("dd-MM-yyyy").parse(today);
        String weekday = DateFormat('E').format(date);

        if (weeklyTotals.containsKey(weekday)) {
          weeklyTotals[weekday] = weeklyTotals[weekday]! + amount;
        }
      }

      // ✅ Convert into BarChartGroupData with correct X-Axis mapping
      List<String> weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

      return List.generate(weekDays.length, (index) {
        String day = weekDays[index]; // Get weekday name
        double totalAmount = weeklyTotals[day]!; // Get total for the day

        return BarChartGroupData(
          x: index, // X-Axis corresponds to week order (0=Sun, 1=Mon, ..., 6=Sat)
          barRods: [
            BarChartRodData(
              toY: totalAmount, // Y-Axis = Total spent on that day
              color: Colors.blueAccent, // Customize bar color
              width: 10, // Customize bar width
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        );
      });
    } catch (e) {
      debugPrint("Error fetching expense data: $e");
      return [];
    }
  }

  static Future<Map<String, dynamic>> getHighestWeeklyExpense(
      String month) async {
    final userID = UserDb.supaUID; // Assuming user authentication

    try {
      final response = await dataBase
          .select('today, amount') // Select today and amount fields
          .eq('user_id', userID)
          .eq('month', month)
          .order('today', ascending: true); // Order by date

      if (response.isEmpty) {
        return {"day": "None", "amount": 0.0}; // No data
      }

      // ✅ Map of total expenses per weekday (Sun - Sat)
      Map<String, double> weeklyTotals = {
        "Sun": 0.0,
        "Mon": 0.0,
        "Tue": 0.0,
        "Wed": 0.0,
        "Thu": 0.0,
        "Fri": 0.0,
        "Sat": 0.0
      };

      for (var expense in response) {
        final String today = expense['today']; // Example: "07-02-2025"
        final double amount = (expense['amount'] as num).toDouble();

        // ✅ Convert `today` (07-02-2025) into a weekday ("Sat")
        DateTime date = DateFormat("dd-MM-yyyy").parse(today);
        String weekday =
            DateFormat('E').format(date); // "E" = Short day format (Sat)

        // ✅ Add amount to the correct weekday
        if (weeklyTotals.containsKey(weekday)) {
          weeklyTotals[weekday] = weeklyTotals[weekday]! + amount;
        }
      }

      // ✅ Get the highest spending day
      return getHighestExpenseDay(weeklyTotals);
    } catch (e) {
      debugPrint("Error fetching highest weekly expense: $e");
      return {"day": "Error", "amount": 0.0}; // Error handling
    }
  }

  /// ✅ Get the highest expense day and amount from the weekly data
  static Map<String, dynamic> getHighestExpenseDay(
      Map<String, double> weeklyTotals) {
    String highestDay = "";
    double highestAmount = 0.0;

    weeklyTotals.forEach((day, amount) {
      if (amount > highestAmount) {
        highestAmount = amount;
        highestDay = day;
      }
    });

    return {
      "day": highestDay,
      "amount": highestAmount,
    };
  }

  static Future<double> getMonthlyExpenseTotal(String month) async {
    final userID = UserDb.supaUID;

    try {
      final response = await dataBase
          .select('amount') // Select only the 'amount' column
          .eq('user_id', userID)
          .eq('month', month); // Filter by month

      if (response.isEmpty) {
        return 0.0; // Return 0 if no expenses exist
      }

      // Sum all amounts
      double total = response.fold(
          0.0, (sum, record) => sum + (record['amount'] as num).toDouble());

      return total;
    } catch (e) {
      log("Error fetching monthly expense total for $month: $e");
      return 0.0;
    }
  }

  static Future<bool> deleteExpense(
    BuildContext context,
    String month,
    int expenseId,
  ) async {
    try {
      final response =
          await dataBase.delete().eq('id', expenseId).select().single();
      log(response.toString());
      // ignore: use_build_context_synchronously
      fetchExpense(context, month);
      AppRoutes.popNow();
      isListExpanded.value = false;
      SnackBarHelper.snackBarSuccess(
        'Delete succesfull',
        'Expense delete succesfull',
      );
      return true;
    } catch (e) {
      SnackBarHelper.snackBarFaild('Oops!', e.toString());
      log("❌ Error deleting expense: $e");
      return false;
    }
  }

  static void fetchExpense(BuildContext context, String month) {
    context.read<ExpenseByDateBloc>().add(FetchExpenseByDateEvent(month));
    context
        .read<ExpenseByCategoryBloc>()
        .add(FetchExpenseByCategoryEvent(month));
    context
        .read<WeeklyExpenseChartBloc>()
        .add(FetchWeeklyExpenseChartEvent(month));
    context.read<HighestExpenseBloc>().add(FetchHighestWeeklyExpenseEvent());
  }
}
