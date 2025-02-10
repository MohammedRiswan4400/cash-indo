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
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
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
      ),
    );
  }
}

// ignore: must_be_immutable
class AppSecondaoryTitle extends StatelessWidget {
  AppSecondaoryTitle({
    super.key,
    required this.title,
    this.subTitle,
  });
  final String title;
  String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GestureDetector(
        onTap: () {
          AppRoutes.popNow();
        },
        child: Row(
          spacing: 10,
          children: [
            Icon(Icons.arrow_back_ios_new),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2.4,
                  // color: Colors.amber,
                  child: AppTextWidget(
                    align: TextAlign.left,
                    maxLine: 1,
                    text: title,
                    size: 18,
                  ),
                ),
                AppTextWidget(
                  text: subTitle ?? '',
                  size: 10,
                  weight: FontWeight.normal,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: AppTextWidget(text: title),
    );
  }
}
