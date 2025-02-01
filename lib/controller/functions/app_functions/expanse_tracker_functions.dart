import 'dart:developer';

import 'package:cash_indo/controller/functions/app_functions/app_functions.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/model/income_model.dart';
import 'package:cash_indo/widget/helper/dialoge_helper_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../widget/helper/snack_bar_helper_widget.dart';

class ExpanseTrackerFunctions {
  static Future<void> updateIncomeCategory({
    required IncomeModel income,
    required String month,
  }) async {
    final String uID = AppFunctions.uid;
    DocumentReference totalAmountRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .collection('income_data')
        .doc(month)
        .collection(income.category)
        .doc('${income.category}_total');

    await totalAmountRef.set(
      {
        '${income.category}_total':
            FieldValue.increment(int.parse(income.amount)),
      },
      SetOptions(merge: true), // Prevents overwriting
    );
  }

  static Future<void> updateIncomeMonthly({
    required IncomeModel income,
    required String month,
  }) async {
    final String uID = AppFunctions.uid;

    DocumentReference totalAmountRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .collection('income_data')
        .doc(month);

    await totalAmountRef.set(
      {
        'monthly_total': FieldValue.increment(double.parse(income.amount)),
      },
      SetOptions(merge: true),
    );
  }

  static Future<void> writeIncome({
    required IncomeModel income,
    required String month,
  }) async {
    try {
      final String uID = AppFunctions.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uID)
          .collection('income_data')
          .doc(month)
          .collection(income.category)
          .add({
        'amount': income.amount,
        'category': income.category,
        'comment': income.comment,
        'currency': income.currency,
        'createdAt': DateTime.now(),
      });
      AppRoutes.popNow();
      updateIncomeCategory(income: income, month: month);
      updateIncomeMonthly(income: income, month: month);
      SnackBarHelper.snackBarSuccess(
        'Succesfull',
        'Income added succesfull',
      );
    } on FirebaseAuthException catch (e) {
      DailogHelper.hideDailoge();
      SnackBarHelper.snackBarFaild(
        'Oops!',
        e.message,
      );
      log(e.message.toString());
    } catch (e) {
      log('Error: $e');
    }
  }
}
