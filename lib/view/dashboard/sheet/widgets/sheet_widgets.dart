import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:flutter/material.dart';

class AddContactWidget extends StatelessWidget {
  const AddContactWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color.fromARGB(255, 92, 36, 81)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: AppTextWidget(
          text: 'Add People +',
          size: 16,
          color: AppColor.kTextColor,
        ),
      ),
    );
  }
}
