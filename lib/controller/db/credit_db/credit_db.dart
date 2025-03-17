import 'dart:developer';

import 'package:cash_indo/controller/db/user_db/user_db.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/model/credit_model.dart';
import 'package:cash_indo/view/dashboard/user_transaction/bloc/credit/credit_list_bloc.dart';
import 'package:cash_indo/widget/expansion_tile.dart';
import 'package:cash_indo/widget/helper/dialoge_helper_widget.dart';
import 'package:cash_indo/widget/helper/snack_bar_helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditDb {
  static final dataBase = Supabase.instance.client.from('credit');

  static Future<void> addCredit({
    required BuildContext context,
    required CreditModel creditModel,
  }) async {
    try {
      DailogHelper.showDailog('Saving Credit...');
      final String uID = UserDb.supaUID;

      if (uID.isEmpty) {
        throw Exception("User is not authenticated.");
      }

      final response = await dataBase.insert(
        {
          'user_id': uID,
          'is_adding': creditModel.isAdding,
          'amount': creditModel.amount,
          'contact_name': creditModel.contactName,
          'contact_phone': creditModel.contactPhone,
          'comment': creditModel.comment,
          'is_send': false,
          'currency': creditModel.currency,
        },
      ).select();

      DailogHelper.hideDailoge();
      AppRoutes.popNow();
      // ignore: use_build_context_synchronously
      CreditDb.fetchCredit(context, creditModel.contactPhone);
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

  static Future<List<CreditModel>> readCredit(
      {required String contactPhone}) async {
    try {
      final String uID = UserDb.supaUID;

      if (uID.isEmpty) {
        throw Exception("User is not authenticated.");
      }

      final response = await dataBase
          .select()
          .eq('user_id', uID)
          .eq('contact_phone', contactPhone);

      if (response.isEmpty) {
        return [];
      }

      List<CreditModel> creditList =
          response.map((data) => CreditModel.fromMap(data)).toList();

      return creditList;
    } catch (e) {
      log('Error fetching credits: $e');
      return [];
    }
  }

  static Future<void> sendMessageToWhatsApp({
    required BuildContext context,
    required int creditId,
    required String phoneNumber,
    required String message,
  }) async {
    Future<bool> isWhatsAppInstalled() async {
      final Uri whatsappCheckUri = Uri.parse("whatsapp://send?phone=");
      // ignore: deprecated_member_use
      return await canLaunch(whatsappCheckUri.toString());
    }

    if (await isWhatsAppInstalled()) {
      final Uri whatsappUri = Uri.parse(
          "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");

      // ignore: deprecated_member_use
      if (await canLaunch(whatsappUri.toString())) {
        // ignore: deprecated_member_use
        await launch(whatsappUri.toString(),
            forceSafariVC: false, forceWebView: false);
        SnackBarHelper.snackBarSuccess(
          'Success!',
          'Your message has been sent successfully.',
        );
        updateIsSendMessage(
            // ignore: use_build_context_synchronously
            context: context,
            creditId: creditId,
            phoneNumber: phoneNumber,
            message: message);
      } else {
        throw "Could not launch WhatsApp.";
      }
    } else {
      SnackBarHelper.snackBarFaild(
        'Oops!',
        'You don\'t have the application required for this purpose',
      );
      log("WhatsApp is not installed.");
    }
  }

  static Future<void> updateIsSendMessage({
    required BuildContext context,
    required int creditId,
    required String phoneNumber,
    required String message,
  }) async {
    try {
      final response =
          await dataBase.update({'is_send': true}).eq('id', creditId).select();
      // ignore: use_build_context_synchronously
      CreditDb.fetchCredit(context, phoneNumber);

      if (response.isEmpty) {
        throw Exception('Update failed: No records updated.');
      }
      log('Successfully updated is_send to true');
    } catch (e) {
      log('Error updating is_send: $e');
    }
  }

  static Future<bool> deleteCredit(
      BuildContext context, int creditId, String phoneNumber) async {
    try {
      final response =
          await dataBase.delete().eq('id', creditId).select().single();
      log(response.toString());
      AppRoutes.popNow();
      // ignore: use_build_context_synchronously
      CreditDb.fetchCredit(context, phoneNumber);
      isListExpanded.value = false;
      SnackBarHelper.snackBarSuccess(
        'Delete succesfull',
        'Credit delete succesfull',
      );
      return true;
    } catch (e) {
      SnackBarHelper.snackBarFaild('Oops!', e.toString());
      log("Error deleting credit: $e");
      return false;
    }
  }

  static void fetchCredit(BuildContext context, String phoneNumber) {
    context.read<CreditListBloc>().add(FetchCreditList(phoneNumber));
  }
}
