import 'package:cash_indo/controller/db/expense_db/expense_db.dart';
import 'package:cash_indo/core/formats/formats_functions.dart';
import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/expanses/category/category_bloc.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/expanses/date/by_date_bloc.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/bottom_sheets.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/widgets/expanse_tracker_widgets.dart';
import 'package:cash_indo/widget/expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpanseTab extends StatelessWidget {
  const ExpanseTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // isListExpanded.value = false;
    return Stack(
      children: [
        SizedBox(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                0.verticalSpace(context),
                ExpanseByDateRange(),
                0.verticalSpace(context),
                ExpanseChartWidget(),
                0.verticalSpace(context),
                AppTextWidget(
                    text: AppConstantStrings.allExpensesTitle, size: 16),
                ExpenseCategoryWidget(),
                10.verticalSpace(context),
                DailyExpenseListTile(),
                20.verticalSpace(context),
              ],
            ),
          ),
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
                              isIncomeSheet: false,
                              isExpanseSheet: true,
                              title: AppConstantStrings.expenses,
                            ),
                            isDismissible: true,
                            enableDrag: true,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                          );
                        },
                        child: const Icon(Icons.add),
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
