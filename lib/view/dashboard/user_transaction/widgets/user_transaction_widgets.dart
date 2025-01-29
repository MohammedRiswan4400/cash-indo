// ignore: must_be_immutable
import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
        child: Center(
          child: AppTextWidget(
            text: text,
            color: AppColor.kTextColor,
          ),
        ),
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
              border: Border.all(width: 0.3),
              color: AppColor.kMainContainerColor,
            ),
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
                        // color: AppColor.kTextColor,
                      ),
                      AppTextWidget(
                        text: 'Comment',
                        size: 12,
                        weight: FontWeight.normal,
                        // color: AppColor.kTextColor,
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
                        // color: AppColor.kTextColor,
                      ),
                      AppTextWidget(
                        text: '12:45 am',
                        size: 12,
                        weight: FontWeight.w600,
                        // color: AppColor.kTextColor,
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
                        color: AppColor.kTextColor,
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
              // Obx(() {
              //   return ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: themeController.isDarkMode.value
              //           ? Colors.deepPurple // Dark mode button color
              //           : Colors.blue, // Light mode button color
              //     ),
              //     onPressed: themeController.toggleTheme,
              //     child: Text("Switch Theme"),
              //   );
              // }),
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
                    // color: AppColor.kTextColor,
                  ),
                  AppTextWidget(
                    text: 'Comment',
                    size: 12,
                    weight: FontWeight.normal,
                    // color: AppColor.kTextColor,
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
                    // color: AppColor.kTextColor,
                  ),
                  AppTextWidget(
                    text: '12:45 am',
                    size: 12,
                    weight: FontWeight.w600,
                    // color: AppColor.kTextColor,
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
