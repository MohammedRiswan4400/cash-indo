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
    // InternetFunction.checkInternet();
    if (AppConst.storage.read(AppConst.isLogged) == null) {
      AppConst.storage.write(AppConst.isLogged, false);
    }

    AppRoutes.goFromSplashScreen();
    return Scaffold(
      backgroundColor: AppColor.kBackgroundColor,
      body:

          //   FutureBuilder<bool>(
          //     future: InternetFunction.checkInternet(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const Center(child: CircularProgressIndicator());
          //       } else if (snapshot.hasData && snapshot.data == true) {
          //         // Internet available, navigate after delay
          //         // Future.delayed(const Duration(seconds: 2), () {
          //         //   Navigator.pushReplacementNamed(
          //         //       context, '/home'); // Change to your home route
          //         // });
          //         AppRoutes.goFromSplashScreen();
          //         return const Center(child: Text("Welcome! Redirecting..."));
          //       } else {
          //         // No Internet, show error
          //         return Center(
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               AppTextWidget(
          //                 text: "No Internet Connection",
          //                 color: Colors.amber,
          //               ),
          //               const SizedBox(height: 10),
          //               ElevatedButton(
          //                 onPressed: () => (context as Element)
          //                     .markNeedsBuild(), // Retry by rebuilding
          //                 child: const Text("Retry"),
          //               ),
          //             ],
          //           ),
          //         );
          //       }
          //     },
          //   ),
          // );

          Padding(
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
