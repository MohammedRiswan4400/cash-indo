import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/balance_sheet_widgets.dart';
import 'package:cash_indo/widget/chart_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ScreenUserTransaction extends StatelessWidget {
  const ScreenUserTransaction({super.key, required this.isDebit});
  final bool isDebit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConst.DashboardScreensHorizontalPadding,
          child: Column(
            children: [
              AppSecondaoryTitle(title: 'Riswan', subTitle: '+91 8138874400'),
              Expanded(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(
                            text: 'Balance',
                            weight: FontWeight.w600,
                            color: AppColor.kArrowColor,
                          ),
                          AppTextWidget(
                            text: '\$ 34,590.00',
                            size: 30,
                            weight: FontWeight.bold,
                            color: AppColor.kArrowColor,
                          ),
                          20.verticalSpace(context),
                          Center(
                            child: SizedBox(
                              height: 200,
                              child: CircleAvatar(
                                radius: 100,
                                backgroundColor: AppColor.kArrowColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: PieChart(
                                    PieChartData(
                                      sections: paiChartDatas(isDebit),
                                      centerSpaceRadius: 0,
                                      sectionsSpace: 0,
                                      startDegreeOffset: 0,
                                      borderData: FlBorderData(show: false),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          5.verticalSpace(context),
                          AppTextWidget(
                            text: '75% Completds',
                            size: 15,
                            weight: FontWeight.bold,
                            color: AppColor.kArrowColor,
                          ),
                          20.verticalSpace(context),
                          10.verticalSpace(context),
                          TransactionListTile(
                            isDebt: isDebit,
                            amount: '',
                            comment: '',
                            date: '',
                            isDecreasing: false,
                            isWhatsAppMessageSend: true,
                            time: '',
                          ),
                          Divider(),
                          TransactionListTile(
                            isDebt: isDebit,
                            amount: '',
                            comment: '',
                            date: '',
                            isDecreasing: false,
                            isWhatsAppMessageSend: false,
                            time: '',
                          ),
                          Divider(),
                          TransactionListTile(
                            isDebt: isDebit,
                            amount: '',
                            comment: '',
                            date: '',
                            isDecreasing: true,
                            isWhatsAppMessageSend: false,
                            time: '',
                          ),
                          // Divider(),
                          // TransactionListTile(
                          //   isDebt: isDebit,
                          //   amount: '',
                          //   comment: '',
                          //   date: '',
                          //   isDecreasing: true,
                          //   isWhatsAppMessageSend: false,
                          //   time: '',
                          // ),
                          // Divider(),
                          // TransactionListTile(
                          //   isDebt: isDebit,
                          //   amount: '',
                          //   comment: '',
                          //   date: '',
                          //   isDecreasing: false,
                          //   isWhatsAppMessageSend: true,
                          //   time: '',
                          // ),
                          // Divider(),
                          // TransactionListTile(
                          //   isDebt: isDebit,
                          //   amount: '',
                          //   comment: '',
                          //   date: '',
                          //   isDecreasing: true,
                          //   isWhatsAppMessageSend: true,
                          //   time: '',
                          // ),
                        ],
                      ),
                    ),
                    LiabilitiesAddingWidget(
                      text: isDebit
                          ? AppConstantStrings.debt
                          : AppConstantStrings.credit,
                      isDebt: isDebit,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AppSecondaoryTitle extends StatelessWidget {
  AppSecondaoryTitle({
    super.key,
    required this.title,
    this.subTitle,
  });
  final String title;
  String? subTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRoutes.popNow();
      },
      child: Row(
        spacing: 10,
        children: [
          Icon(Icons.arrow_back_ios_new),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(
                text: title,
                size: 18,
              ),
              AppTextWidget(
                text: subTitle ?? '',
                size: 10,
                weight: FontWeight.normal,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TransactionScreenDebtOrCreditCard extends StatelessWidget {
  const TransactionScreenDebtOrCreditCard({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromARGB(255, 64, 55, 130),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(child: AppTextWidget(text: text)),
      ),
    );
  }
}

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({
    super.key,
    required this.isDecreasing,
    required this.amount,
    required this.comment,
    required this.date,
    required this.time,
    required this.isWhatsAppMessageSend,
    required this.isDebt,
  });
  final bool isDecreasing;
  final String amount;
  final String comment;
  final String date;
  final String time;
  final bool isDebt;
  final bool isWhatsAppMessageSend;
  @override
  Widget build(BuildContext context) {
    return !isWhatsAppMessageSend
        ? Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 48, 48, 48)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: isDebt
                        ? isDecreasing
                            ? const Color.fromARGB(255, 164, 255, 144)
                            : const Color.fromARGB(255, 255, 144, 144)
                        : !isDecreasing
                            ? const Color.fromARGB(255, 255, 144, 144)
                            : const Color.fromARGB(255, 164, 255, 144),
                    child: Icon(
                      // isDebt
                      //     ?
                      isDecreasing
                          ? Icons.keyboard_arrow_down_rounded
                          : Icons.keyboard_arrow_up_rounded,
                      // : !isDecreasing
                      //     ? Icons.keyboard_arrow_down_rounded
                      //     : Icons.keyboard_arrow_up_rounded,
                      color: AppColor.kArrowColor,
                    ),
                  ),
                  20.horizontalSpace(context),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        text: '\$ 45,999.00',
                        size: 15,
                        weight: FontWeight.w600,
                        color: AppColor.kTextColor,
                      ),
                      AppTextWidget(
                        text: 'Comment',
                        size: 12,
                        weight: FontWeight.normal,
                        color: AppColor.kTextColor,
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppTextWidget(
                        text: '04/01/24',
                        size: 14,
                        weight: FontWeight.w600,
                        color: AppColor.kTextColor,
                      ),
                      AppTextWidget(
                        text: '12:45 am',
                        size: 12,
                        weight: FontWeight.w600,
                        color: AppColor.kTextColor,
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 102, 202, 136),
                          // const Color.fromARGB(255, 109, 255, 96),
                          const Color.fromARGB(255, 49, 100, 46)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.wechat_sharp,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: isDecreasing
                    ? const Color.fromARGB(255, 164, 255, 144)
                    : const Color.fromARGB(255, 255, 144, 144),
                child: Icon(
                  isDecreasing
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.keyboard_arrow_up_rounded,
                  color: AppColor.kArrowColor,
                ),
              ),
              20.horizontalSpace(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text: '\$ 45,999.00',
                    size: 15,
                    weight: FontWeight.w600,
                    color: AppColor.kTextColor,
                  ),
                  AppTextWidget(
                    text: 'Comment',
                    size: 12,
                    weight: FontWeight.normal,
                    color: AppColor.kTextColor,
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppTextWidget(
                    text: '04/01/24',
                    size: 14,
                    weight: FontWeight.w600,
                    color: AppColor.kTextColor,
                  ),
                  AppTextWidget(
                    text: '12:45 am',
                    size: 12,
                    weight: FontWeight.w600,
                    color: AppColor.kTextColor,
                  ),
                ],
              ),
              // Spacer(),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(
              //       10,
              //     ),
              //     gradient: LinearGradient(
              //       colors: [
              //         const Color.fromARGB(255, 109, 255, 96),
              //         const Color.fromARGB(255, 49, 100, 46)
              //       ],
              //       begin: Alignment.topCenter,
              //       end: Alignment.bottomCenter,
              //     ),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(4.0),
              //     child: Icon(
              //       Icons.wechat_sharp,
              //       size: 30,
              //     ),
              //   ),
              // )
            ],
          );
  }
}
