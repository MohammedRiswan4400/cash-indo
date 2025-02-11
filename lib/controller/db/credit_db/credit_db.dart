import 'dart:developer';

import 'package:cash_indo/controller/db/user_db/user_db.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/model/credit_model.dart';
import 'package:cash_indo/widget/helper/dialoge_helper_widget.dart';
import 'package:cash_indo/widget/helper/snack_bar_helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreditDb {
  static final dataBase = Supabase.instance.client.from('credit');

  static Future<void> addCredit({
    required CreditModel creditModel,
  }) async {
    try {
      DailogHelper.showDailog('Saving Credit...');
      final String uID = UserDb.supaUID;

      if (uID.isEmpty) {
        throw Exception("User is not authenticated.");
      }

      final response = await dataBase.insert({
        'user_id': uID,
        'amount': creditModel.amount,
        'contact_name': creditModel.contactName,
        'contact_phone': creditModel.contactPhone,
        'comment': creditModel.comment,
        'is_send': false,
        'currency': creditModel.currency,
      }).select();

      DailogHelper.hideDailoge();
      AppRoutes.popNow();
      // CreditDb.fetchCredit(
      //     // ignore: use_build_context_synchronously
      //     context,
      //     AppFormats.monthFormattedDate(DateTime.now()));
      if (response.isNotEmpty) {
        SnackBarHelper.snackBarSuccess(
          'Succesfull',
          'Credit added succesfull',
        );
      } else {
        throw Exception("Failed to save Credit.");
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
}
