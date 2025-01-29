import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/widget/appbar_widget.dart';
import 'package:cash_indo/widget/dialoge_boxes.dart';
import 'package:cash_indo/view/dashboard/savings/widgets/savings_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenSavings extends StatelessWidget {
  const ScreenSavings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConst.DashboardScreensHorizontalPadding,
          child: Column(
            children: [
              CustomeAppBar(title: AppConstantStrings.savings),
              10.verticalSpace(context),
              Expanded(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SavingsContainer(),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 00,
                      child: Row(
                        children: [
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Get.dialog(
                                Dialog(
                                  backgroundColor: Colors.black,
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: SavingsAmountAddingDialoge(
                                    isAdding: true,
                                  ),
                                ),
                              );
                            },
                            child: AddSavingWidget(),
                          ),
                          Spacer()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
