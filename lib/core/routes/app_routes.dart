import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/view/auth/login/screen_login.dart';
import 'package:cash_indo/view/auth/sign_up/screen_sign_up.dart';
import 'package:cash_indo/view/dashboard/bottom_navigation/screen_bottom_navigation.dart';
import 'package:cash_indo/view/dashboard/savings/screen_savings.dart';
import 'package:cash_indo/view/dashboard/user_transaction/screen_user_transaction.dart';
import 'package:get/get.dart';

class AppRoutes {
  static goFromSplashScreen() async {
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
    ).then(
      (value) {
        Get.offAll(AppConst.storage.read(AppConst.isLogged)
            ? ScreenBottonNavigation()
            : ScreenLogin());
      },
    );
  }

  static gotoScreenSignUp() {
    Get.offAll(
      () => ScreenSignUp(),
      transition: Transition.fadeIn,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
  }

  static gotoScreenSignIn() {
    Get.offAll(
      () => ScreenLogin(),
      transition: Transition.fadeIn,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
  }

  static gotoBottomNavigation() {
    Get.offAll(() => ScreenBottonNavigation());
  }

  static gotoScreenUserTransaction(bool isDebit) {
    Get.to(
      () => ScreenUserTransaction(isDebit: isDebit),
    );
  }

  static gotoScreenSavings() {
    Get.to(() => ScreenSavings());
  }

  static popNow() {
    Get.back();
  }
}
