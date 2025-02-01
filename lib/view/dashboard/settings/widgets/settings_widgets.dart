// ignore: must_be_immutable
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SettingsTile extends StatelessWidget {
  SettingsTile({
    super.key,
    required this.text,
    this.textColor,
    required this.isIcon,
    this.onTap,
  });
  final String text;
  Color? textColor;
  final bool isIcon;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextWidget(text: text, size: 18, color: textColor),
          isIcon
              ? Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                )
              : SizedBox()
        ],
      ),
    );
  }
}
