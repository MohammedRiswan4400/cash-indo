import 'package:cash_indo/core/constant/app_texts_const.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:flutter/material.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    AppRoutes.goFromSplashScreen();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Image.asset('assets/icon/ic_app_icon.png'),
            AppTextWidget(text: AppTextsConst.splashText, size: 12)
          ],
        ),
      ),
    );
  }
}
