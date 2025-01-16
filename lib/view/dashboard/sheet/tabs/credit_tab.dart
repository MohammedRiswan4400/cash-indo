import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/balance_sheet_widgets.dart';
import 'package:flutter/material.dart';

class CreditTab extends StatelessWidget {
  const CreditTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
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
          ),
        ),
        // 0.verticalSpace(context),
        UserListTile(),
        UserListTile(),
        UserListTile(),
      ],
    );
  }
}
