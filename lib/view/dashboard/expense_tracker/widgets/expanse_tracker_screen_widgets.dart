import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/view/auth/sign_up/screen_sign_up.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/view/dashboard/home/widgets/home_screen_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
// Tab One +++++++++++++++++++++++++++++++++++++++++++++++++++++

// First Widget ----------------------------------------

class ExpanseByDateRange extends StatelessWidget {
  const ExpanseByDateRange({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColor.kExpanseByDateRangeContainerColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ExpanceTitleAndAmount(
              title: 'Day',
              amount: '6,12,000',
            ),
            AppTextWidget(
              text: '|',
              size: 15,
              weight: FontWeight.w500,
              color: AppColor.kTextColor,
            ),
            ExpanceTitleAndAmount(
              title: 'Week',
              amount: '69,000',
            ),
            AppTextWidget(
              text: '|',
              size: 15,
              weight: FontWeight.w500,
              color: AppColor.kTextColor,
            ),
            ExpanceTitleAndAmount(
              title: 'Month',
              amount: '6,000',
            ),
          ],
        ),
      ),
    );
  }
}

// FirstWidget sub widgets ----------------------------------------

class ExpanceTitleAndAmount extends StatelessWidget {
  const ExpanceTitleAndAmount({
    super.key,
    required this.title,
    required this.amount,
  });
  final String title;
  final String amount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 4,
      child: Column(
        spacing: 8,
        children: [
          AppTextWidget(
            text: title,
            size: 15,
            weight: FontWeight.w800,
            color: AppColor.kTextColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 2,
            children: [
              AppTextWidget(
                text: AppConstantStrings.rupees,
                size: 17,
                color: AppColor.kTextColor,
              ),
              AppTextAutoSize(
                text: amount,
                size: 17,
                maxLine: 1,
                color: AppColor.kTextColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Second Widget ----------------------------------------

class ExpanseChartWidget extends StatelessWidget {
  const ExpanseChartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.kContainerColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4, left: 4, right: 4, top: 10),
        child: Column(
          spacing: 5,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextWidget(
                  text: 'Weekly Tracker',
                  size: 17,
                  weight: FontWeight.w600,
                  color: AppColor.kInvertedTextColor,
                ),
                Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    legendWidgets(
                      color: Colors.green,
                      text: AppConstantStrings.week,
                    ),
                    // legendWidgets(
                    //   color: Colors.redAccent,
                    //   text: AppConstantStrings.lastWeek,
                    // ),
                  ],
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              height: 220,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BarChart(
                  curve: Curves.bounceIn,
                  transformationConfig: FlTransformationConfig(
                    panEnabled: false,
                    scaleEnabled: false,
                  ),
                  BarChartData(
                    extraLinesData: ExtraLinesData(extraLinesOnTop: false),
                    backgroundColor: const Color.fromARGB(255, 4, 51, 42),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                    ),
                    maxY: 100,
                    barGroups: expanseTrackerChartGroupes(),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // Space between items
              children: AppConstantStrings.allWeeks.map((day) {
                return AppTextWidget(
                  text: day,
                  size: 11,
                  weight: FontWeight.w600,
                  color: AppColor.kInvertedTextColor,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// Sub Widget
List<BarChartGroupData> expanseTrackerChartGroupes() {
  return List.generate(
    listDataModel.length,
    (index) {
      final active = double.parse(listDataModel[index].value!);
      // final absent = active - index * 5;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: active,
            color: Colors.green,
            width: 25,
            backDrawRodData: BackgroundBarChartRodData(
              toY: active,
              color: Colors.redAccent,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
        ],
      );
    },
  );
}

// Currency Selector ------------------------------------

// ignore: must_be_immutable
class ExpanseTile extends StatelessWidget {
  ExpanseTile({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    this.color,
    required this.trail,
  });
  final IconData icon;
  final String title;
  final String amount;
  final String trail;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: color ?? const Color.fromARGB(255, 214, 227, 161),
          child: Icon(icon, color: AppColor.kInvertedTextColor),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextWidget(
              text: title,
              size: 15,
            ),
            Row(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppTextWidget(
                  text: AppConstantStrings.rupees,
                  size: 12,
                  weight: FontWeight.w500,
                ),
                AppTextWidget(
                  text: amount,
                  size: 13,
                  weight: FontWeight.w700,
                ),
              ],
            ),
          ],
        ),
        Spacer(),
        Align(
          alignment: Alignment.bottomRight,
          child: AppTextWidget(
            text: trail,
            size: 13,
            weight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Tab Two +++++++++++++++++++++++++++++++++++++++++++++++++++++

// First Widget ----------------------------------------

class IncomeProgressBarWidget extends StatelessWidget {
  const IncomeProgressBarWidget({
    super.key,
    required this.title,
    required this.amount,
  });
  final String title;
  final String amount;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        AppTextWidget(
          text: title,
          size: 18,
          weight: FontWeight.w600,
        ),
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: themeController.isDarkMode.value
                ? AppColor.kContainerColor
                : AppColor.kHomeCreditContainerColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                // height: ,
                width: MediaQuery.sizeOf(context).width / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: themeController.isDarkMode.value
                      ? AppColor.kHomeCreditContainerColor
                      : AppColor.kContainerColor,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: AppTextWidget(
            text: '\$ $amount',
            size: 16,
            weight: FontWeight.w600,
            align: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
