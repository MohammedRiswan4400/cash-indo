import 'package:cash_indo/controller/theme/theme_controller.dart';
import 'package:cash_indo/core/theme/theme_helper.dart';
import 'package:cash_indo/view/splash/screen_splash.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(),
    ),
  );
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
        home: ScreenSplash(),
      );
    });
  }
}
