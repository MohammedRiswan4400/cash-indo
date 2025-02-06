import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/expanse_tab.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/income_tab.dart';
import 'package:cash_indo/widget/appbar_widget.dart';
import 'package:cash_indo/widget/tab_bar_widgets.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/drop_down_widgets.dart';
import 'package:flutter/material.dart';

class ScreenExpenseTracker extends StatelessWidget {
  const ScreenExpenseTracker({super.key});

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
                AppBarWidget(title: AppConstantStrings.expanseTracker),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TabsWidget(
                        firstTab: AppConstantStrings.expenses,
                        secondTab: AppConstantStrings.income),
                    MonthDropDownWidget(),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ExpanseTab(),
                      IncomeTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
