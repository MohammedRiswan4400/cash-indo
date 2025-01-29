import 'dart:developer';

import 'package:cash_indo/controller/functions/auth/auth.dart';
import 'package:cash_indo/widget/helper/dialoge_helper_widget.dart';
import 'package:cash_indo/widget/helper/snack_bar_helper_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthFunctions {
  static Future createUserWithEmailAndPassword({
    required BuildContext ctx,
    required String email,
    required String password,
  }) async {
    try {
      DailogHelper.showDailog('Creating...');
      await Auth()
          .createUserWithEmailAndPassword(email: email, password: password);
      // storage.write(isLogged, true);

      // ignore: use_build_context_synchronously
      // ScreenRoutes.gotoScreenAuthProfile(ctx, email);
      // DailogHelper.hideDailoge();
      // log('SignUp Success');
    } on FirebaseAuthException catch (e) {
      DailogHelper.hideDailoge();
      SnackBarHelper.snackBarFaild(
        'Oops!',
        e.message,
      );
      log(e.message.toString());
    }
  }

  static Future signInWithEmailAndPassword({
    required BuildContext ctx,
    required String email,
    required String password,
  }) async {
    try {
      DailogHelper.showDailog('Login...');
      await Auth().signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // storage.write(isLogged, true);
      // // ignore: use_build_context_synchronously
      // ScreenRoutes.gotoScreenHome(ctx);
      DailogHelper.hideDailoge();
      log('Login Success');
    } on FirebaseAuthException catch (e) {
      DailogHelper.hideDailoge();
      SnackBarHelper.snackBarFaild(
        'Oops!',
        e.message,
      );
      log(e.message.toString());
    }
  }

  static Future signOut(context) async {
    await Auth().signOut();

    // storage.write(isLogged, false);
    // storage.write(isProfile, false);
    // ScreenRoutes.gotoScreenLogin(context);
    log('Sign out Success');
  }
}
