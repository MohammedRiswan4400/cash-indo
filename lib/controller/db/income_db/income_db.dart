import 'dart:developer';

import 'package:cash_indo/controller/db/user_db/user_db.dart';
import 'package:cash_indo/controller/functions/date_and_time/date_and_time_formates.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/model/income_model.dart';
import 'package:cash_indo/widget/helper/dialoge_helper_widget.dart';
import 'package:cash_indo/widget/helper/snack_bar_helper_widget.dart';
import 'package:intl/intl.dart';
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
            final todayDate = income['today'] as String?; // Allow null values

            if (todayDate != null) {
              // Only group if 'today' is not null
              if (!groupedData.containsKey(todayDate)) {
                groupedData[todayDate] = [];
              }

              groupedData[todayDate]!.add(incomeModel);
            }
          }

          return groupedData.values.toList();
        });
  }

  static Stream<double> getTotalAmountForMonth(String month) {
    final userID = UserDb.supaUID;

    return dataBase
        .stream(primaryKey: ['id'])
        .eq('user_id', userID) // Filter by user ID
        .map((data) {
          double totalAmount = 0.0;

          for (var income in data) {
            final incomeMonth = income['month']
                as String; // Assuming 'month' is stored as a String (e.g., "01" for January)
            final amount = income['amount']
                as double; // Assuming 'amount' is stored as a double

            // Check if the income belongs to the specified month
            if (incomeMonth == month) {
              totalAmount += amount; // Add to the total amount
            }
          }

          return totalAmount; // Return the total amount for the month
        });
  }
  // static Stream<List<IncomeModel>> readContacts() {
  //   final userID = UserDb.supaUID;
  //   return dataBase.stream(primaryKey: ['id']).eq('user_id', userID).map(
  //       (data) => data.map((income) => IncomeModel.fromMap(income)).toList());
  // }
}
