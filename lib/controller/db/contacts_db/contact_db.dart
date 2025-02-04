import 'dart:developer';

import 'package:cash_indo/controller/db/user_db/user_db.dart';
import 'package:cash_indo/controller/functions/app_functions/app_functions.dart';
import 'package:cash_indo/model/contact_model.dart';
import 'package:cash_indo/widget/helper/dialoge_helper_widget.dart';
import 'package:cash_indo/widget/helper/snack_bar_helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContactDb {
  static final dataBase = Supabase.instance.client.from('contacts');

  //write contact
  static Future<void> addContact(
      {required ValueNotifier<List<Contact>> contactsNotifier,
      required Contact contactModel,
      required String phoneNumber}) async {
    try {
      DailogHelper.showDailog('Saving ...');
      final String uID = UserDb.supaUID;

      if (uID.isEmpty) {
        throw Exception("User is not authenticated.");
      }

      final response = await dataBase.insert({
        'user_id': uID,
        'name': contactModel.fullName,
        'phone': phoneNumber,
        'created_at': DateTime.now().toIso8601String(),
      }).select();

      DailogHelper.hideDailoge();

      if (response.isNotEmpty) {
        contactsNotifier.value = List.from(contactsNotifier.value)
          ..remove(contactModel);

        SnackBarHelper.snackBarSuccess(
          'Success',
          'Contact saved successfully',
        );
      } else {
        throw Exception("Failed to save contact.");
      }
    } on AuthException catch (e) {
      DailogHelper.hideDailoge();
      SnackBarHelper.snackBarFaild('Oops!', e.message);
      log('Auth Error: ${e.message}');
    } catch (e) {
      DailogHelper.hideDailoge();
      log('Error: $e');
      SnackBarHelper.snackBarFaild('Oops!', 'An error occurred while saving.');
    }
  }

  //read contact
  static Stream<List<ContactModel>> readContacts() {
    final userID = UserDb.supaUID;
    return dataBase.stream(primaryKey: ['id']).eq('user_id', userID).map(
        (data) =>
            data.map((contact) => ContactModel.fromMap(contact)).toList());
  }
}
