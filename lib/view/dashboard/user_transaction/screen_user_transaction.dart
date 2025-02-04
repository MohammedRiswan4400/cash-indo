import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/view/dashboard/user_transaction/tabs/credit_tab.dart';
import 'package:cash_indo/view/dashboard/user_transaction/tabs/debit_tab.dart';
import 'package:cash_indo/widget/appbar_widget.dart';
import 'package:cash_indo/widget/tab_bar_widgets.dart';
import 'package:flutter/material.dart';

class ScreenUserTransaction extends StatelessWidget {
  const ScreenUserTransaction({super.key, required this.isDebit});
  final bool isDebit;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: AppConst.DashboardScreensHorizontalPadding,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppSecondaoryTitle(
                        title: 'Riswan', subTitle: '+91 8138874400'),
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
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      CreditTab(),
                      DebitTab(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
