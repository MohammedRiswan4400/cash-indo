import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/expansion_tile.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
          border: Border.all(color: AppColor.kContainerColor),
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromARGB(135, 255, 255, 255),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TabBar(
            onTap: (value) {
              isListExpanded.value = false;
            },
            labelPadding: EdgeInsets.zero,
            isScrollable: false,
            indicatorPadding: EdgeInsets.zero,
            dividerHeight: 0,
            physics: const BouncingScrollPhysics(),
            indicator: BoxDecoration(
              color: AppColor.kContainerColor,
              borderRadius: BorderRadius.circular(100),
            ),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(
                iconMargin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AppTextWidget(
                    text: firstTab,
                    size: 14,
                    color: AppColor.kBackgroundColor,
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
                    color: AppColor.kBackgroundColor,
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
