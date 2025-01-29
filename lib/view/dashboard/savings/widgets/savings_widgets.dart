import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/app_widgets.dart';
import 'package:cash_indo/widget/dialoge_boxes.dart';
import 'package:cash_indo/widget/expansion_tile.dart';
import 'package:cash_indo/view/dashboard/home/widgets/home_screen_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingsContainer extends StatelessWidget {
  const SavingsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.sizeOf(context).width / 2
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(96, 130, 128, 128),
            const Color.fromARGB(57, 71, 69, 69)
          ],
          end: Alignment.bottomLeft,
          begin: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextWidget(
              text: 'Car fund',
              size: 18,
              weight: FontWeight.w700,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).width / 2.23,
                  width: MediaQuery.sizeOf(context).width / 2.2,
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
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).width / 2.5,
                  width: MediaQuery.sizeOf(context).width / 2.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        text: AppConstantStrings.achivmentTitle,
                        size: 14,
                        align: TextAlign.start,
                        maxLine: 1,
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
                            text: AppConstantStrings.constantAmount,
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
                            text: AppConstantStrings.constantAmount,
                            size: 22,
                            align: TextAlign.start,
                            maxLine: 1,
                          ),
                        ],
                      ),
                      Spacer(),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.dialog(
                              Dialog(
                                backgroundColor: Colors.black,
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: SavingsAmountAddingDialoge(
                                  isAdding: false,
                                  title: 'Car Fund',
                                ),
                              ),
                            );
                          },
                          child: ButtonWithoutIcon(
                            text: AppConstantStrings.boostSavings,
                            size: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            5.verticalSpace(context),
            CustomExpansionTile(
              leading: AppTextWidget(text: '📈'),
              title: 'Savings Journey',
              children: [
                Icon(Icons.abc_outlined),
                Icon(Icons.abc_outlined),
                Icon(Icons.abc_outlined),
                Icon(Icons.abc_outlined),
                Icon(Icons.abc_outlined),
                Icon(Icons.abc_outlined),
                Icon(Icons.abc_outlined)
              ],
            ),
            5.verticalSpace(context)
          ],
        ),
      ),
    );
  }
}

class AddSavingWidget extends StatelessWidget {
  const AddSavingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromARGB(255, 69, 96, 61),
        border: Border.all(width: 0.5),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 5),
            blurRadius: 10,
            spreadRadius: 0,
            color: AppColor.kshadowColor,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: AppTextWidget(
          text: 'Add Savings Goal',
          size: 16,
          color: AppColor.kTextColor,
        ),
      ),
    );
  }
}
