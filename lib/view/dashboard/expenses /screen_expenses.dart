import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/view/auth/sign_up/screen_sign_up.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ScreenExpenses extends StatelessWidget {
  const ScreenExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: AppConst.DashboardScreensHorizontalPadding,
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextWidget(text: AppConstantStrings.expanseTracker),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 190,
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColor.kContainerColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TabBar(
                            labelPadding: EdgeInsets.zero,
                            isScrollable: false,
                            indicatorPadding: EdgeInsets.zero,
                            dividerHeight: 0,
                            physics: const BouncingScrollPhysics(),
                            indicator: BoxDecoration(
                              color: AppColor.kBackgroundColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            labelColor: AppColor.kTextColor,
                            unselectedLabelColor: AppColor.kBackgroundColor,
                            tabs: [
                              Tab(
                                iconMargin: EdgeInsets.zero,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: AppTextWidget(
                                    text: AppConstantStrings.expenses,
                                    size: 14,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  child: AppTextWidget(
                                    text: AppConstantStrings.income,
                                    size: 14,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 40, 84, 97),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Row(
                        spacing: 10,
                        children: [
                          AppTextWidget(
                            text: 'January',
                            size: 16,
                            weight: FontWeight.bold,
                            color: AppColor.kTextColor,
                          ),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            color: AppColor.kTextColor,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
      ),
    );
  }
}
