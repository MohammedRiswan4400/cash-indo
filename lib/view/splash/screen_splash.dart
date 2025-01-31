import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:flutter/material.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    if (AppConst.storage.read(AppConst.isLogged) == null) {
      AppConst.storage.write(AppConst.isLogged, false);
    }

    AppRoutes.goFromSplashScreen();
    return Scaffold(
      backgroundColor: AppColor.kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Image.asset('assets/icon/ic_app_icon.png'),
            AppTextWidget(
              text: AppConstantStrings.splashText,
              size: 12,
              color: AppColor.kTextColor,
            )
          ],
        ),
      ),
    );
  }
}
