import 'dart:developer';

import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/model/income_model.dart';
import 'package:cash_indo/model/user_model.dart';
import 'package:cash_indo/view/dashboard/sheet/tabs/credit_tab.dart';
import 'package:cash_indo/widget/helper/dialoge_helper_widget.dart';
import 'package:cash_indo/widget/helper/snack_bar_helper_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';

class AppFunctions {
  static String uid = FirebaseAuth.instance.currentUser!.uid;

  //Read User Profile
  static Stream<UserModel?> readProfile() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.empty();
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('personal_data')
        .doc('profile')
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return UserModel.fromMap(snapshot.data()!);
      }
      return null;
    });
  }

  //add contact

  static Future<void> addContact(
      {required ValueNotifier<List<Contact>> contactsNotifier,
      required Contact contactModel,
      required String phoneNumber}) async {
    try {
      DailogHelper.showDailog('Saving ...');
      final String uID = AppFunctions.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uID)
          .collection('contacts')
          .doc(contactModel.fullName)
          .set({
        'name': contactModel.fullName,
        'contact_number': phoneNumber,
        'createdAt': DateTime.now(),
      });

      DailogHelper.hideDailoge();
      // contactsNotifier.value =
      //                                       List.from(contacts)
      //                                         ..remove(contact);
      contactsNotifier.value = List.from(contactsNotifier.value)
        ..remove(contactModel);

      SnackBarHelper.snackBarSuccess(
        'Success',
        'Contact saved successfully',
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
