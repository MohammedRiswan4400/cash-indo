import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColor.kContainerColor,
        border: Border.all(width: 0.5),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 5),
            blurRadius: 10,
            spreadRadius: 0,
            color: AppColor.kshadowColor,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            AppTextWidget(
              text: text,
              size: 15,
              color: AppColor.kInvertedTextColor,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.kInvertedTextColor,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
