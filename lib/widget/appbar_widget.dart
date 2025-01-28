import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:flutter/material.dart';

class CustomeAppBar extends StatelessWidget {
  const CustomeAppBar({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 20,
      children: [
        GestureDetector(
          onTap: () {
            AppRoutes.popNow();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        AppTextWidget(
          text: title,
        )
      ],
    );
  }
}
