import 'dart:developer';

import 'package:cash_indo/controller/db/user_db/user_db.dart';
import 'package:cash_indo/controller/functions/app_functions/app_functions.dart';
import 'package:cash_indo/controller/functions/auth/auth.dart';
import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/model/user_model.dart';
import 'package:cash_indo/widget/helper/dialoge_helper_widget.dart';
import 'package:cash_indo/widget/helper/snack_bar_helper_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthFunctions {
  final SupabaseClient supabase = Supabase.instance.client;
  static Future<Object?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      DailogHelper.showDailog('Creating ...');
      final response = await Supabase.instance.client.auth
          .signUp(email: email, password: password);
      log("SignUp Successful: ${response.user?.email}");
      DailogHelper.hideDailoge();
      AppRoutes.gotoBottomNavigation();
      AppConst.storage.write(AppConst.isLogged, true);
      UserDb.createUserProfile(
          UserModel(name: name, email: email, phoneNumber: phoneNumber));
      SnackBarHelper.snackBarSuccess(
        'Welcome to Cash Indo!',
        'Manage your money with ease.',
      );
      log('User account created and profile data saved!');
    } catch (e) {
      if (e is AuthException) {
        DailogHelper.hideDailoge();
        SnackBarHelper.snackBarFaild('Oops!', e.message);
        log("SignUp Failed: ${e.message}");
        return e.message;
      } else {
        SnackBarHelper.snackBarFaild('Oops!', "An unexpected error occurred.");

        return "An unexpected error occurred.";
      }
    } finally {
      log("Sign-in attempt completed.");
    }
    return null;
    // try {
    //   DailogHelper.showDailog('Creating ...');
    //   final String uID = AppFunctions.uid;
    //   await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(uID)
    //       .collection('personal_data')
    //       .doc('profile')
    //       .set({
    //     'name': name,
    //     'email': email,
    //     'phoneNumber': phoneNumber,
    //     'createdAt': DateTime.now(),
    //   });
    //   DailogHelper.hideDailoge();
    //   AppRoutes.gotoBottomNavigation();
    //   AppConst.storage.write(AppConst.isLogged, true);
    //   SnackBarHelper.snackBarSuccess(
    //     'Welcome to Cash Indo!',
    //     'Manage your money with ease.',
    //   );
    //   log('User account created and profile data saved!');
    // } on FirebaseAuthException catch (e) {
    //   DailogHelper.hideDailoge();
    //   SnackBarHelper.snackBarFaild(
    //     'Oops!',
    //     e.message,
    //   );
    //   log(e.message.toString());
    // } catch (e) {
    //   log('Error: $e');
    // }
  }

  static Future<Object?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      DailogHelper.showDailog('Login...');
      final response = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);

      log("Login Successful: ${response.user?.email}");
      AppConst.storage.write(AppConst.isLogged, true);

      DailogHelper.hideDailoge();
      AppRoutes.gotoBottomNavigation();
      SnackBarHelper.snackBarSuccess(
        'Welcome Back!',
        'Let’s take control of your finances.',
      );

      log('Login Success');
      return response;
    } catch (e) {
      if (e is AuthException) {
        DailogHelper.hideDailoge();
        SnackBarHelper.snackBarFaild('Oops!', e.message);
        log("Login Failed: ${e.message}");
        return e.message;
      } else {
        SnackBarHelper.snackBarFaild('Oops!', "An unexpected error occurred.");

        return "An unexpected error occurred.";
      }
    } finally {
      log("Sign-in attempt completed.");
    }
    // try {
    //   DailogHelper.showDailog('Login...');
    //   await Auth().signInWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //   );
    //   AppConst.storage.write(AppConst.isLogged, true);

    //   DailogHelper.hideDailoge();
    //   AppRoutes.gotoBottomNavigation();
    //   SnackBarHelper.snackBarSuccess(
    //     'Welcome Back!',
    //     'Let’s take control of your finances.',
    //   );

    //   log('Login Success');
    // } on FirebaseAuthException catch (e) {
    //   DailogHelper.hideDailoge();
    //   SnackBarHelper.snackBarFaild(
    //     'Oops!',
    //     e.message,
    //   );
    //   log(e.message.toString());
    // }
  }

  static Future signOut() async {
    final supabase = Supabase.instance.client;
    await supabase.auth.signOut();
    // await Auth().signOut();

    AppConst.storage.write(AppConst.isLogged, false);
    AppRoutes.gotoScreenSignIn();
    log('Sign out Success');
  }

  static Future<void> deleteAccount(TextEditingController controller) async {
    try {
      DailogHelper.showDailog('Account Deleting...');

      final Session? session = Supabase.instance.client.auth.currentSession;

      if (session != null) {
        // AuthCredential credential = EmailAuthProvider.credential(
        //   email: user.email!,
        //   password: controller.text.trim(),
        // );
        await Supabase.instance.client.auth.admin.deleteUser(session.user.id);

        // await user.reauthenticateWithCredential(credential);

        // await user.delete();
        DailogHelper.hideDailoge();
        AppConst.storage.write(AppConst.isLogged, false);
        AppRoutes.gotoScreenSignIn();
        log(session.user.email!);
        log("User account deleted successfully!");
      }
    } on FirebaseAuthException catch (e) {
      DailogHelper.hideDailoge();
      SnackBarHelper.snackBarFaild(
        'Oops!',
        e.message,
      );
      log(e.message.toString());
    }
  }
}
