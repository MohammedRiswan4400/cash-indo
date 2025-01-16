import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/view/dashboard/sheet/tabs/credit_tab.dart';
import 'package:cash_indo/view/dashboard/sheet/tabs/debit_tab.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/tab_bar_widgets.dart';
import 'package:flutter/material.dart';

class ScreenBalanceSheet extends StatelessWidget {
  const ScreenBalanceSheet({super.key});

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
                AppTextWidget(text: AppConstantStrings.balanceSheet),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TabsWidget(
                        width: 150,
                        firstTab: AppConstantStrings.credit,
                        secondTab: AppConstantStrings.debt),
                    // MonthDropDownWidget(),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      CreditTab(),
                      DebitTab(),
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
