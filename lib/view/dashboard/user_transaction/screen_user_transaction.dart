import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/model/contact_model.dart';
import 'package:cash_indo/view/dashboard/user_transaction/tabs/credit_tab.dart';
import 'package:cash_indo/view/dashboard/user_transaction/tabs/debit_tab.dart';
import 'package:cash_indo/widget/appbar_widget.dart';
import 'package:cash_indo/widget/tab_bar_widgets.dart';
import 'package:flutter/material.dart';

class ScreenUserTransaction extends StatelessWidget {
  const ScreenUserTransaction({
    super.key,
    required this.isDebit,
    required this.contactModel,
  });
  final bool isDebit;
  final ContactModel contactModel;
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
                        title: contactModel.name,
                        subTitle: contactModel.phoneNumber),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: TabsWidget(
                          width: 150,
                          firstTab: AppConstantStrings.credit,
                          secondTab: AppConstantStrings.debt),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      CreditTab(
                        contactModel: contactModel,
                      ),
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
