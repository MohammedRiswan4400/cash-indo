import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColor.kContainerColor,
      ),
      child: Center(
        child: AppTextWidget(
          text: title,
          size: 16,
          weight: FontWeight.w600,
          color: AppColor.kInvertedTextColor,
        ),
      ),
    );
  }
}

class AppButtonDim extends StatelessWidget {
  const AppButtonDim({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColor.kContainerDimColor,
      ),
      child: Center(
        child: AppTextWidget(
          text: title,
          size: 16,
          weight: FontWeight.w600,
          color: AppColor.kInvertedTextColor,
        ),
      ),
    );
  }
}
