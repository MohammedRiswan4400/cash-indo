import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/view/auth/sign_up/screen_sign_up.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:flutter/material.dart';

class TabsWidget extends StatelessWidget {
  TabsWidget({
    super.key,
    required this.firstTab,
    required this.secondTab,
    this.width,
  });
  double? width;
  final String firstTab;
  final String secondTab;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 190,
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
              // color: AppColor.kTextColor,
            ),
            labelColor:
                // themeController.isDarkMode.value
                //     ? AppColor.kTextColor
                //     :
                AppColor.kTextColor,
            unselectedLabelColor: AppColor.kBackgroundColor,
            tabs: [
              Tab(
                iconMargin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AppTextWidget(
                    text: firstTab,
                    size: 14,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: AppTextWidget(
                    text: secondTab,
                    size: 14,
                    weight: FontWeight.bold,
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
