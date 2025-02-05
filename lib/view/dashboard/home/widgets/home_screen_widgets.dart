import 'dart:math';

import 'package:cash_indo/controller/db/user_db/user_db.dart';
import 'package:cash_indo/controller/functions/date_and_time/date_and_time_formates.dart';
import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/core/images/app_images.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/model/user_model.dart';
import 'package:cash_indo/view/auth/sign_up/screen_sign_up.dart';
import 'package:cash_indo/view/dashboard/bottom_navigation/screen_navigation.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/app_widgets.dart';
import 'package:cash_indo/widget/bottom_sheets.dart';
import 'package:cash_indo/widget/helper/shimmer_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// First widget ----------------------------------------

class CashCardWidget extends StatelessWidget {
  const CashCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DateTime todayDate = DateTime.now();
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 0, 46, 89),
            const Color.fromARGB(255, 9, 32, 53),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTextWidget(
                text: AppDateFormates.slashFormattedDate(todayDate),
                size: 15,
                weight: FontWeight.w500,
                color: AppColor.kTextColor),
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppTextWidget(
                    text: AppConstantStrings.balanceOfThisMonth,
                    isUnderLine: true,
                    size: 13,
                    weight: FontWeight.w500,
                    color: AppColor.kTextColor,
                  ),
                  AppTextWidget(
                    text: AppConstantStrings.balanceAmount,
                    size: 40,
                    weight: FontWeight.bold,
                    color: AppColor.kTextColor50,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<UserModel?>(
                  stream: UserDb.getUserByEmail(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ShimmerErrorWidget(
                        firstHeight: 10,
                        firstWidth: 100,
                        secondHeight: 15,
                        secondWidth: 150,
                      );
                    } else if (snapshot.hasError) {
                      return ShimmerErrorWidget(
                        firstHeight: 10,
                        firstWidth: 100,
                        secondHeight: 15,
                        secondWidth: 150,
                      );
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return ShimmerErrorWidget(
                        firstHeight: 15,
                        firstWidth: 100,
                        secondHeight: 22,
                        secondWidth: 150,
                      );
                    }

                    UserModel user = snapshot.data!;
                    String name = user.name;
                    String phoneNumber = user.phoneNumber;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                          text: name,
                          size: 15,
                          weight: FontWeight.w500,
                          color: AppColor.kTextColor,
                        ),
                        AppTextWidgetWithGFound(
                          text: '+91 $phoneNumber',
                          size: 20,
                          weight: FontWeight.w900,
                          color: AppColor.kTextColor,
                        ),
                      ],
                    );
                  },
                ),
                GestureDetector(
                  onTap: () {
                    //  final userID =   AuthFunctions.getCurrentUserId();
                    // log(UserDb.supaUID);
                  },
                  child: Image.asset(
                    AppImages.masterCardImage,
                    scale: 2,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Second Widget ----------------------------------------

class ChartWidget extends StatelessWidget {
  const ChartWidget({
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
                  text: AppConstantStrings.trackYourExpenses,
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
                    legendWidgets(
                      color: Colors.redAccent,
                      text: AppConstantStrings.lastWeek,
                    ),
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
                    // gridData: FlGridData(show: false,),
                    backgroundColor: const Color.fromARGB(255, 62, 62, 62),
                    // const Color.fromARGB(255, 125, 164, 112),
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
                    barGroups: chartGroupes(),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

// Third widget ----------------------------------------

class TodayFinaceRowWidget extends StatelessWidget {
  const TodayFinaceRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppTextWidget(
          text: AppConstantStrings.organizeTodatFinance,
          size: 15,
          align: TextAlign.start,
          maxLine: 2,
        ),
        Transform.rotate(
          angle: pi / -2,
          child: CustomPaint(
            size: const Size(100, 100),
            painter: SplitAfterLinePainter(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    MoneyKeyboardBottomSheet(
                      isExpanseSheet: true,
                      title: AppConstantStrings.expenses,
                    ),
                    isDismissible: true,
                    enableDrag: true,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                  );
                },
                child: FinanceButton(
                  title: AppConstantStrings.expenses,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    MoneyKeyboardBottomSheet(
                      isExpanseSheet: false,
                      title: AppConstantStrings.income,
                    ),
                    isDismissible: true,
                    enableDrag: true,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                  );
                },
                child: FinanceButton(
                  title: AppConstantStrings.income,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

// Fourth widget ----------------------------------------

class SavingsWidget extends StatelessWidget {
  SavingsWidget({super.key});
  final ValueNotifier<bool> _isObscure = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).width / 2,
              width: MediaQuery.sizeOf(context).width / 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(96, 130, 128, 128),
                    const Color.fromARGB(22, 71, 69, 69)
                  ],
                  end: Alignment.bottomLeft,
                  begin: Alignment.topRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: PieChart(
                        PieChartData(
                          sections: savingsDonotChart(),
                          centerSpaceRadius: 30,
                          sectionsSpace: 4,
                        ),
                      ),
                    ),
                    5.verticalSpace(context),
                    AppTextWidget(
                      text: AppConstantStrings.savingsCompletedText,
                      size: 13,
                      align: TextAlign.center,
                      weight: FontWeight.w500,
                      maxLine: 2,
                    ),
                    AppTextWidget(
                      text: AppConstantStrings.savingsMotivationquate,
                      size: 10,
                      align: TextAlign.start,
                      weight: FontWeight.w500,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 12,
              top: 10,
              child: ValueListenableBuilder<bool>(
                  valueListenable: _isObscure,
                  builder: (context, value, _) {
                    return GestureDetector(
                      onTap: () {
                        _isObscure.value = !_isObscure.value;
                      },
                      child: Icon(
                        value
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        color: AppColor.kSecondaryTextColor,
                      ),
                    );
                  }),
            )
          ],
        ),
        ValueListenableBuilder(
            valueListenable: _isObscure,
            builder: (context, value, _) {
              return SizedBox(
                height: MediaQuery.sizeOf(context).width / 2,
                width: MediaQuery.sizeOf(context).width / 2.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: AppConstantStrings.achivmentTitle,
                      size: 14,
                      align: TextAlign.start,
                      maxLine: 1,
                      color: AppColor.kDimGreyColot,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppTextWidget(
                          text: AppConstantStrings.rupees,
                          size: 16,
                          align: TextAlign.start,
                          maxLine: 1,
                        ),
                        AppTextWidget(
                          text: value
                              ? AppConstantStrings.constantAmount
                              : AppConstantStrings.obscureTexts,
                          size: 18,
                          align: TextAlign.start,
                          maxLine: 1,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppTextWidget(
                        text: AppConstantStrings.targetTitle,
                        size: 20,
                        align: TextAlign.start,
                        maxLine: 1,
                        color: AppColor.kDimGreyColot,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppTextWidget(
                          text: AppConstantStrings.rupees,
                          size: 18,
                          align: TextAlign.start,
                          maxLine: 1,
                        ),
                        AppTextWidget(
                          text: value
                              ? AppConstantStrings.constantAmount
                              : AppConstantStrings.obscureTexts,
                          size: 22,
                          align: TextAlign.start,
                          maxLine: 1,
                        ),
                      ],
                    ),
                    Spacer(),
                    AppTextWidget(
                      text: value
                          ? AppConstantStrings.savingFor
                          : AppConstantStrings.obscureSavingFor,
                      size: 10,
                      align: TextAlign.start,
                      weight: FontWeight.w300,
                      maxLine: 2,
                    ),
                    Spacer(),
                    value
                        ? GestureDetector(
                            onTap: () {
                              AppRoutes.gotoScreenSavings();
                            },
                            child: ButtonWithIcon(
                                text: AppConstantStrings.gotoSavings))
                        : SizedBox(height: 33)
                  ],
                ),
              );
            }),
      ],
    );
  }
}

// Fifth widget ----------------------------------------

class CreditWidget extends StatelessWidget {
  const CreditWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GestureDetector(
          onTap: () {
            indexChangeNotifier.value = 2;
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: themeController.isDarkMode.value
                  ? AppColor.kHomeCreditContainerColor
                  : const Color.fromARGB(180, 184, 184, 184),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextWidget(
                        text: AppConstantStrings.credit,
                        size: 16,
                        align: TextAlign.start,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                      )
                    ],
                  ),
                  Row(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppTextWidget(
                        text: AppConstantStrings.rupees,
                        size: 14,
                        weight: FontWeight.w500,
                        align: TextAlign.start,
                      ),
                      AppTextWidget(
                        text: AppConstantStrings.constantAmount,
                        size: 18,
                        weight: FontWeight.w700,
                        align: TextAlign.start,
                      ),
                    ],
                  ),
                  Container(
                    height: 45,
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
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: AppTextWidget(
                  //     text: AppConstantStrings.seeAll,
                  //     size: 12,
                  //     weight: FontWeight.w600,
                  //     align: TextAlign.start,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// SecondWidget sub widgets ----------------------------------------

List<BarChartGroupData> chartGroupes() {
  return List.generate(
    listDataModel.length,
    (index) {
      final active = double.parse(listDataModel[index].value!);
      final absent = active - index * 5;
      return BarChartGroupData(x: index, barRods: [
        BarChartRodData(
          toY: absent,
          color: Colors.redAccent,
          //  const Color.fromARGB(255, 164, 85, 85),
          width: 5,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.circular(2),
          ),
        ),
        BarChartRodData(
          toY: active,
          color: Colors.green,
          // const Color.fromARGB(255, 125, 164, 112),
          width: 20,
          backDrawRodData: BackgroundBarChartRodData(
            toY: active + 20,
            color: Colors.redAccent,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
      ]);
    },
  );
}

final List<DataModel> listDataModel = [
  DataModel(key: '01', value: '25'),
  DataModel(key: '02', value: '26'),
  DataModel(key: '03', value: '68'),
  DataModel(key: '04', value: '85'),
  DataModel(key: '05', value: '46'),
  DataModel(key: '06', value: '78'),
  DataModel(key: '07', value: '45'),
];

// ignore: camel_case_types
class legendWidgets extends StatelessWidget {
  const legendWidgets({
    super.key,
    required this.color,
    required this.text,
  });
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 6,
        ),
        AppTextWidget(
          text: text,
          size: 12,
          weight: FontWeight.w600,
          color: AppColor.kInvertedTextColor,
        )
      ],
    );
  }
}

class DataModel {
  final String? key;
  final String? value;

  DataModel({required this.key, required this.value});
}

// ThirdWidget sub widgets ----------------------------------------

class FinanceButton extends StatelessWidget {
  const FinanceButton({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColor.kContainerColor,
        border: Border.all(width: 0.5),
        boxShadow: [
          BoxShadow(
            offset: Offset(5, 1),
            blurRadius: 10,
            spreadRadius: 0,
            color: AppColor.kshadowColor,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: AppTextWidget(
          text: title,
          size: 12,
          color: AppColor.kInvertedTextColor,
        ),
      ),
    );
  }
}

class SplitAfterLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.kArrowColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Draw initial straight line of 20 pixels
    path.moveTo(size.width / 2, 0); // Starting point
    path.lineTo(size.width / 2, 30); // End of the straight line

    // Draw left rounded curve starting after the straight line
    path.moveTo(size.width / 2, 30); // Starting point of the curve
    path.quadraticBezierTo(
      size.width / 4, // Control point X
      size.height / 3, // Control point Y
      size.width / 4, // End point X
      size.height - 20, // End point Y
    );
    // Draw left arrowhead
    path.moveTo(size.width / 4, size.height - 20);
    path.lineTo(size.width / 4 - 10, size.height - 30);
    path.moveTo(size.width / 4, size.height - 20);
    path.lineTo(size.width / 4 + 10, size.height - 30);

    // Draw right rounded curve starting after the straight line
    path.moveTo(size.width / 2, 30); // Starting point of the curve
    path.quadraticBezierTo(
      size.width / 1.3, // Control point X
      size.height / 3, // Control point Y
      3 * size.width / 4, // End point X
      size.height - 20, // End point Y
    );
    // Draw right arrowhead
    path.moveTo(3 * size.width / 4, size.height - 20);
    path.lineTo(3 * size.width / 4 - 10, size.height - 30);
    path.moveTo(3 * size.width / 4, size.height - 20);
    path.lineTo(3 * size.width / 4 + 10, size.height - 30);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// FourthWidget sub widgets ----------------------------------------

List<PieChartSectionData> savingsDonotChart() {
  return [
    PieChartSectionData(
      color: Colors.green,
      value: 30,
      title: '',
      radius: 20,
      titleStyle: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    PieChartSectionData(
      color: const Color.fromARGB(255, 170, 170, 170),
      value: 20,
      title: '',
      radius: 20,
      titleStyle: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  ];
}
