import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/widgets/income_tracker_widget.dart';

import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/bottom_sheets.dart';
import 'package:cash_indo/widget/drop_down_widgets.dart';
import 'package:cash_indo/widget/expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeTab extends StatelessWidget {
  const IncomeTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // isListExpanded.value = false;
    return Stack(
      children: [
        SizedBox(
          child: ValueListenableBuilder(
              valueListenable: selectedMonthNotifier,
              builder: (context, selectedMonth, _) {
                return SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        text: '$selectedMonth Income',
                        color: AppColor.kArrowColor,
                      ),
                      MonthlyTotalWidget(),
                      CategoryTotalWidget(),
                      DailyIncomeListTileWidget(),
                      30.verticalSpace(context),
                    ],
                  ),
                );
              }),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: isListExpanded,
          builder: (context, isExpanded, _) {
            return Positioned(
              bottom: 20,
              right: 10,
              child: AnimatedOpacity(
                opacity: !isExpanded ? 1.0 : 0.0,
                duration: Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                child: !isExpanded
                    ? FloatingActionButton(
                        onPressed: () {
                          Get.bottomSheet(
                            MoneyKeyboardBottomSheet(
                              thisIs: 'Income',
                              // isIncomeSheet: true,
                              // isExpanseSheet: false,
                              title: AppConstantStrings.income,
                            ),
                            isDismissible: true,
                            enableDrag: true,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                          );
                        },
                        child: Icon(Icons.add),
                      )
                    : SizedBox(),
              ),
            );
          },
        ),
      ],
    );
  }
}
