import 'dart:developer';

import 'package:cash_indo/controller/db/user_db/user_db.dart';
import 'package:cash_indo/controller/functions/date_and_time/date_and_time_formates.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/model/expense_model.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/expanses/date/by_date_bloc.dart';
import 'package:cash_indo/widget/helper/dialoge_helper_widget.dart';
import 'package:cash_indo/widget/helper/snack_bar_helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        'year': AppDateFormates.yearFormattedDate(DateTime.now()),
        'month': AppDateFormates.monthFormattedDate(DateTime.now()),
        'today': AppDateFormates.barFormattedDate(DateTime.now()),
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
          context, AppDateFormates.monthFormattedDate(DateTime.now()));
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

  static void fetchExpense(BuildContext context, String month) {
    context.read<ExpenseByDateBloc>().add(FetchExpenseByDateEvent(month));
  }
}
