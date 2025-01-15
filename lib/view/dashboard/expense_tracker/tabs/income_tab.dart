import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/view/auth/sign_up/screen_sign_up.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/bottom_sheets.dart';
import 'package:cash_indo/widget/expanse_tracker_screen_widgets.dart';
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
                10.verticalSpace,
                AppTextWidget(
                  text: AppConstantStrings.incomeTracker,
                ),
                5.verticalSpace,
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
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextWidget(
                      text: AppConstantStrings.today,
                      size: 18,
                      weight: FontWeight.w800,
                      align: TextAlign.start,
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    )
                  ],
                ),
                5.verticalSpace,
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTextWidget(
                            text: '\$ 20,985.00',
                            size: 16,
                            weight: FontWeight.w600,
                            align: TextAlign.start,
                          ),
                          AppTextWidget(
                            text: '(Job)',
                            size: 15,
                            color: AppColor.kArrowColor,
                            weight: FontWeight.w500,
                            align: TextAlign.start,
                          ),
                        ],
                      );
                    }),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextWidget(
                      text: '15-01-2025',
                      size: 18,
                      weight: FontWeight.w800,
                      align: TextAlign.start,
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    )
                  ],
                ),
                5.verticalSpace,
                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTextWidget(
                            text: '\$ 20,985.00',
                            size: 16,
                            weight: FontWeight.w600,
                            align: TextAlign.start,
                          ),
                          AppTextWidget(
                            text: '(Buisness)',
                            size: 15,
                            color: AppColor.kArrowColor,
                            weight: FontWeight.w500,
                            align: TextAlign.start,
                          ),
                        ],
                      );
                    }),
                ElevatedButton(
                  onPressed: themeController.toggleTheme,
                  child: Obx(() {
                    return Text(
                      themeController.isDarkMode.value
                          ? "Switch to Light Mode"
                          : "Switch to Dark Mode",
                    );
                  }),
                ),
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
