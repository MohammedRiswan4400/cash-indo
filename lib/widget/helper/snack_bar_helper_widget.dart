import 'package:cash_indo/core/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SnackBarHelper {
  static void snackBarSuccess(String? title, String? content) {
    Get.snackbar(
      title!,
      content!,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black54,
      colorText: AppColor.kTextColor,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 1),
    );
  }

  static void snackBarFaild(
    String? title,
    String? content,
  ) {
    Get.snackbar(
      title!,
      content!,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black54,
      colorText: AppColor.kTextColor,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      icon: const Icon(
        Icons.info,
        color: AppColor.kTextColor,
      ),
      duration: const Duration(seconds: 1),
    );
  }
}
