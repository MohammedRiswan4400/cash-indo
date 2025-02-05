import 'dart:developer';

import 'package:cash_indo/controller/db/user_db/user_db.dart';
import 'package:cash_indo/controller/functions/date_and_time/date_and_time_formates.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/model/income_model.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/income/monthly_income/income_monthly_total_bloc.dart';
import 'package:cash_indo/widget/helper/dialoge_helper_widget.dart';
import 'package:cash_indo/widget/helper/snack_bar_helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IncomeDb {
  //

  static final dataBase = Supabase.instance.client.from('income');

  //write
  static Future<void> addIncome({required IncomeModel incomeModel}) async {
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
        'category': incomeModel.category,
        'amount': incomeModel.amount,
        'comment': incomeModel.comment,
        'currency': incomeModel.currency,
        'created_at': DateTime.now().toIso8601String(),
      }).select();

      DailogHelper.hideDailoge();
      AppRoutes.popNow();
      if (response.isNotEmpty) {
        SnackBarHelper.snackBarSuccess(
          'Succesfull',
          'Income added succesfull',
        );
      } else {
        throw Exception("Failed to save Income.");
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
  static Stream<List<List<IncomeModel>>> readIncome() {
    final userID = UserDb.supaUID;

    return dataBase
        .stream(primaryKey: ['id'])
        .eq('user_id', userID)
        .map((data) {
          final groupedData = <String, List<IncomeModel>>{};

          for (var income in data) {
            final incomeModel = IncomeModel.fromMap(income);
            final todayDate = income['today'] as String?;

            if (todayDate != null) {
              if (!groupedData.containsKey(todayDate)) {
                groupedData[todayDate] = [];
              }

              groupedData[todayDate]!.add(incomeModel);
            }
          }
          return groupedData.values.toList();
        });
  }

  static Future<double> getMonthlyIncomeTotal(String month) async {
    final userID = UserDb.supaUID;

    try {
      final response = await Supabase.instance.client
          .from('income')
          .select('amount')
          .eq('user_id', userID)
          .eq('month', month);

      if (response.isEmpty) {
        return 0.0;
      }

      double total = response.fold(
          0.0, (sum, record) => sum + (record['amount'] as num).toDouble());

      return total;
    } catch (e) {
      log("Error fetching monthly total for $month: $e");
      return 0.0;
    }
  }

  static void fetchIncome(BuildContext context, String month) {
    context.read<IncomeMonthlyTotalBloc>().add(FetchMonthlyIncomeTotal(month));
  }
}
