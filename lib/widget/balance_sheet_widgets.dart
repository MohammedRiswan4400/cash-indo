import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        CircleAvatar(radius: 25, child: AppTextWidget(text: 'R')),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextWidget(
              text: 'Riswan',
              size: 17,
            ),
            AppTextWidget(
              text: '+91 8138874400',
              size: 15,
              weight: FontWeight.normal,
            ),
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AppTextWidget(
              text: '\$ 34,560.00',
              size: 15,
              weight: FontWeight.normal,
            ),
            AppTextWidget(
              text: '16-01-2025',
              size: 14,
              weight: FontWeight.normal,
            ),
          ],
        ),
      ],
    );
  }
}
