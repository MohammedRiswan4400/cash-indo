import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/home__screen_widgets.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConst.DashboardScreensHorizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(text: AppConstantStrings.appName),
              AppTextWidget(text: AppConstantStrings.subName, size: 12),
              10.verticalSpace,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      1.verticalSpace,
                      CashCardWidget(),
                      1.verticalSpace,
                      ChartWidget(),
                      1.verticalSpace,
                      TodayFinaceRowWidget(),
                      AppTextWidget(
                        text: AppConstantStrings.savingsTitle,
                        size: 16,
                        align: TextAlign.start,
                        maxLine: 2,
                      ),
                      SavingsWidget(),
                      1.verticalSpace,
                      CreditWidget(),
                      20.verticalSpace,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
