import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/bottom_sheets.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/widgets/expanse_tracker_screen_widgets.dart';
import 'package:cash_indo/widget/expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeTab extends StatelessWidget {
  const IncomeTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextWidget(
                  text: 'January Income',
                  color: AppColor.kArrowColor,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: AppTextWidget(
                        text: AppConstantStrings.rupees,
                        size: 18,
                        color: AppColor.kArrowColor,
                      ),
                    ),
                    AppTextWidget(
                      text: AppConstantStrings.constantAmount,
                      color: AppColor.kArrowColor,
                      size: 30,
                    ),
                  ],
                ),
                10.verticalSpace(context),
                AppTextWidget(
                  text: AppConstantStrings.incomeTracker,
                ),
                5.verticalSpace(context),
                IncomeProgressBarWidget(
                  title: 'Job',
                  amount: '12,909.00',
                ),
                IncomeProgressBarWidget(
                  title: 'Trade',
                  amount: '12,909.00',
                ),
                IncomeProgressBarWidget(
                  title: 'Buisness',
                  amount: '12,909.00',
                ),
                // 10.verticalSpace(context),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     AppTextWidget(
                //       text: AppConstantStrings.today,
                //       size: 18,
                //       weight: FontWeight.w800,
                //       align: TextAlign.start,
                //     ),
                //     Icon(
                //       Icons.arrow_forward_ios_rounded,
                //       size: 20,
                //     )
                //   ],
                // // ),
                // 5.verticalSpace(context),
                10.verticalSpace(context),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 0.2),
                      color: AppColor.kMainContainerColor),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: CustomExpansionTile(
                      leading: AppTextWidget(text: '📆'),
                      title: AppConstantStrings.today,
                      children: [
                        ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppTextWidget(
                                  text: '\$ 20,985.00',
                                  size: 16,
                                  weight: FontWeight.w600,
                                  align: TextAlign.start,
                                ),
                                20.horizontalSpace(context),
                                AppTextWidget(
                                  text: '(Job)',
                                  size: 15,
                                  color: AppColor.kArrowColor,
                                  weight: FontWeight.w500,
                                  align: TextAlign.start,
                                ),
                                Spacer(),
                                AppTextWidget(
                                  text: '12:23 am',
                                  size: 15,
                                  color: AppColor.kArrowColor,
                                  weight: FontWeight.w500,
                                  align: TextAlign.start,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                10.verticalSpace(context),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 0.2),
                      color: AppColor.kMainContainerColor),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: CustomExpansionTile(
                      leading: AppTextWidget(text: '📆'),
                      title: '30-01-25',
                      children: [
                        ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppTextWidget(
                                  text: '\$ 20,985.00',
                                  size: 16,
                                  weight: FontWeight.w600,
                                  align: TextAlign.start,
                                ),
                                20.horizontalSpace(context),
                                AppTextWidget(
                                  text: '(Job)',
                                  size: 15,
                                  color: AppColor.kArrowColor,
                                  weight: FontWeight.w500,
                                  align: TextAlign.start,
                                ),
                                Spacer(),
                                AppTextWidget(
                                  text: '12:23 am',
                                  size: 15,
                                  color: AppColor.kArrowColor,
                                  weight: FontWeight.w500,
                                  align: TextAlign.start,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                30.verticalSpace(context),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 10,
          child: FloatingActionButton(
            onPressed: () {
              Get.bottomSheet(
                MoneyKeyboardBottomSheet(
                  isIncomeSheet: true,
                  isExpanseSheet: false,
                  title: AppConstantStrings.income,
                ),
                isDismissible: true,
                enableDrag: true,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
