import 'dart:developer';

import 'package:cash_indo/controller/db/user_db/user_db.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/model/debit_model.dart';
import 'package:cash_indo/view/dashboard/user_transaction/bloc/debit/debit_list_bloc.dart';
import 'package:cash_indo/widget/expansion_tile.dart';
import 'package:cash_indo/widget/helper/dialoge_helper_widget.dart';
import 'package:cash_indo/widget/helper/snack_bar_helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DebitDb {
  static final dataBase = Supabase.instance.client.from('debit');

  static Future<void> addDebit({
    required BuildContext context,
    required DebitModel debitModel,
  }) async {
    try {
      DailogHelper.showDailog('Saving Debit...');
      final String uID = UserDb.supaUID;

      if (uID.isEmpty) {
        throw Exception("User is not authenticated.");
      }

      final response = await dataBase.insert(
        {
          'user_id': uID,
          'is_adding': debitModel.isAdding,
          'amount': debitModel.amount,
          'contact_name': debitModel.contactName,
          'contact_phone': debitModel.contactPhone,
          'comment': debitModel.comment,
          'is_send': false,
          'currency': debitModel.currency,
        },
      ).select();

      DailogHelper.hideDailoge();
      AppRoutes.popNow();
      // ignore: use_build_context_synchronously
      DebitDb.fetchDebit(context, debitModel.contactPhone);
      if (response.isNotEmpty) {
        SnackBarHelper.snackBarSuccess(
          'Succesfull',
          'Debit added succesfull',
        );
      } else {
        throw Exception("Failed to save Debit.");
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

  static Future<List<DebitModel>> readDebit(
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

      List<DebitModel> debitList =
          response.map((data) => DebitModel.fromMap(data)).toList();

      return debitList;
    } catch (e) {
      log('Error fetching debits: $e');
      return [];
    }
  }

  static Future<void> sendMessageToWhatsApp({
    required BuildContext context,
    required int debitId,
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
            debitId: debitId,
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
    required int debitId,
    required String phoneNumber,
    required String message,
  }) async {
    try {
      final response =
          await dataBase.update({'is_send': true}).eq('id', debitId).select();
      // ignore: use_build_context_synchronously
      DebitDb.fetchDebit(context, phoneNumber);

      if (response.isEmpty) {
        throw Exception('Update failed: No records updated.');
      }
      log('Successfully updated is_send to true');
    } catch (e) {
      log('Error updating is_send: $e');
    }
  }

  static Future<bool> deleteDebit(
      BuildContext context, int debitId, String phoneNumber) async {
    try {
      final response =
          await dataBase.delete().eq('id', debitId).select().single();
      log(response.toString());
      AppRoutes.popNow();
      // ignore: use_build_context_synchronously
      DebitDb.fetchDebit(context, phoneNumber);
      isListExpanded.value = false;
      SnackBarHelper.snackBarSuccess(
        'Delete succesfull',
        'Debit delete succesfull',
      );
      return true;
    } catch (e) {
      SnackBarHelper.snackBarFaild('Oops!', e.toString());
      log("Error deleting debit: $e");
      return false;
    }
  }

  static void fetchDebit(BuildContext context, String phoneNumber) {
    context.read<DebitListBloc>().add(FetchDebitList(phoneNumber));
  }
}
