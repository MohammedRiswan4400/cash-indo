import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/view/dashboard/home/widgets/home_screen_widgets.dart';
import 'package:cash_indo/widget/appbar_widget.dart';
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
              AppBarWidget(title: AppConstantStrings.appName),
              AppTextWidget(text: AppConstantStrings.subName, size: 12),
              10.verticalSpace(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      1.verticalSpace(context),
                      CashCardWidget(),
                      1.verticalSpace(context),
                      ChartWidget(),
                      1.verticalSpace(context),
                      TodayFinaceRowWidget(),
                      AppTextWidget(
                        text: AppConstantStrings.savingsTitle,
                        size: 16,
                        align: TextAlign.start,
                        maxLine: 2,
                      ),
                      SavingsWidget(),
                      1.verticalSpace(context),
                      CreditWidget(),
                      20.verticalSpace(context),
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
