import 'package:cash_indo/view/auth/login/screen_login.dart';
import 'package:cash_indo/view/auth/sign_up/screen_sign_up.dart';
import 'package:cash_indo/view/dashboard/bottom_navigation/screen_bottom_navigation.dart';
import 'package:get/get.dart';

class AppRoutes {
  static goFromSplashScreen() async {
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
    ).then(
      (value) {
        Get.offAll(ScreenLogin());
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
}
