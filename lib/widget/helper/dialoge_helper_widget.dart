import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailogHelper {
  static void shoeErrorDailog({
    BuildContext? context,
    String title = "Error",
    String? description,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: AppColor.kInvertedTextColor,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(
            100,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextWidget(
                text: title,
                // style: GoogleFonts.inder(
                //   color: kWhite,
                //   fontWeight: FontWeight.bold,
                // ),
              ),
              AppTextWidget(
                text: description ?? 'Somthing went wrong',
              ),
              GestureDetector(
                onTap: () {
                  hideDailoge();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    color: AppColor.kInvertedTextColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AppTextWidget(
                      text: "Ok",
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static void showDailog([String? message]) {
    Get.dialog(
      Dialog(
        backgroundColor: AppColor.kInvertedTextColor,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(
            100,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            spacing: 30,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: AppColor.kTextColor,
              ),
              AppTextWidget(
                text: message ?? "",
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void hideDailoge() {
    if (Get.isDialogOpen!) Get.back();
  }
}
