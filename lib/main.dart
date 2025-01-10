import 'package:cash_indo/controller/theme/theme_controller.dart';
import 'package:cash_indo/core/theme/theme_helper.dart';
import 'package:cash_indo/view/splash/screen_splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return Obx(() {
      return GetMaterialApp(
        title: 'Cash Indo',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        // theme: ThemeData(
        //   useMaterial3: true,
        //   scaffoldBackgroundColor: AppColor.kBackgroundColor,
        // ),
        home: ScreenSplash(),
      );
    });
  }
}
