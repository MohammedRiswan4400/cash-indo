// ignore: must_be_immutable
import 'package:cash_indo/controller/db/credit_db/credit_db.dart';
import 'package:cash_indo/controller/db/debit_db/debit_db.dart';
import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/core/formats/formats_functions.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/widgets/expanse_tracker_widgets.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/dialoge_boxes.dart';
import 'package:cash_indo/widget/expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    required this.isIncreasing,
    required this.amount,
    required this.comment,
    required this.date,
    required this.time,
    required this.isWhatsAppMessageSend,
    required this.isDebt,
    required this.currency,
    required this.id,
    required this.phoneNumber,
  });
  final bool isIncreasing;
  final String amount;
  final String currency;
  final String comment;
  final String date;
  final String time;
  final String phoneNumber;
  final bool isDebt;
  final int id;
  final bool isWhatsAppMessageSend;
  @override
  Widget build(BuildContext context) {
    return !isWhatsAppMessageSend
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 0.2),
              color: AppColor.kMainContainerColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: isDebt
                            ? !isIncreasing
                                ? const Color.fromARGB(255, 164, 255, 144)
                                : const Color.fromARGB(255, 255, 144, 144)
                            : isIncreasing
                                ? const Color.fromARGB(255, 255, 144, 144)
                                : const Color.fromARGB(255, 164, 255, 144),
                        child: Icon(
                          !isIncreasing
                              ? Icons.keyboard_arrow_down_rounded
                              : Icons.keyboard_arrow_up_rounded,
                          color: AppColor.kArrowColor,
                        ),
                      ),
                      AppTextWidget(
                        text: '$currency ${AppFormats.moneyFormat(amount)}',
                        size: 16,
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppTextWidget(
                            text: date,
                            size: 12,
                            weight: FontWeight.w600,
                          ),
                          AppTextWidget(
                            text: time,
                            size: 12,
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                      // Spacer(),
                      isWhatsAppMessageSend
                          ? SizedBox()
                          : GestureDetector(
                              onTap: () {
                                CreditDb.sendMessageToWhatsApp(
                                    message: '''Cash Indo
Hey ,\nI need the $currency $amount back. Let me know when you can send it.''',
                                    context: context,
                                    creditId: id,
                                    phoneNumber: phoneNumber);
                              },
                              child: WhatsappContainer()),
                    ],
                  ),
                  CustomExpansionTileUser(
                    children: [
                      // Divider(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          comment == ''
                              ? AppTextWidget(
                                  text: 'No comment',
                                  size: 12,
                                  align: TextAlign.left,
                                  weight: FontWeight.normal,
                                  // color: AppColor.kTextColor,
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: SizedBox(
                                    // color: Colors.amber,
                                    width: MediaQuery.sizeOf(context).width / 1,
                                    child: AppTextWidget(
                                      text: comment,
                                      size: 12,
                                      align: TextAlign.left,
                                      weight: FontWeight.normal,
                                      // color: AppColor.kTextColor,
                                    ),
                                  ),
                                ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            spacing: 10,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.dialog(
                                    Dialog(
                                      backgroundColor: Colors.black,
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: DeleteDialogeBox(
                                        deleteWhat: isDebt ? 'Debit' : 'Credit',
                                        ontap: () {
                                          isDebt
                                              ? DebitDb.deleteDebit(
                                                  context, id, phoneNumber)
                                              : CreditDb.deleteCredit(
                                                  context, id, phoneNumber);
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: smallButton(
                                  isDelete: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // 10.verticalSpace(context)
                    ],
                  ),
                ],
              ),
            ),
          )
        : Column(
            children: [
              Row(
                spacing: 10,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: isDebt
                        ? !isIncreasing
                            ? const Color.fromARGB(255, 164, 255, 144)
                            : const Color.fromARGB(255, 255, 144, 144)
                        : isIncreasing
                            ? const Color.fromARGB(255, 255, 144, 144)
                            : const Color.fromARGB(255, 164, 255, 144),
                    child: Icon(
                      !isIncreasing
                          ? Icons.keyboard_arrow_down_rounded
                          : Icons.keyboard_arrow_up_rounded,
                      color: AppColor.kArrowColor,
                    ),
                  ),
                  AppTextWidget(
                    text: '$currency ${AppFormats.moneyFormat(amount)}',
                    size: 16,
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppTextWidget(
                        text: date,
                        size: 12,
                        weight: FontWeight.w600,
                      ),
                      AppTextWidget(
                        text: time,
                        size: 12,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
              5.verticalSpace(context),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.2),
                  color: AppColor.kMainContainerColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: CustomExpansionTileUser(
                    children: [
                      // Divider(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          comment == ''
                              ? AppTextWidget(
                                  text: 'No comment',
                                  size: 12,
                                  align: TextAlign.left,
                                  weight: FontWeight.normal,
                                  // color: AppColor.kTextColor,
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: SizedBox(
                                    // color: Colors.amber,
                                    width: MediaQuery.sizeOf(context).width / 1,
                                    child: AppTextWidget(
                                      text: comment,
                                      size: 12,
                                      align: TextAlign.left,
                                      weight: FontWeight.normal,
                                      // color: AppColor.kTextColor,
                                    ),
                                  ),
                                ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            spacing: 10,
                            children: [
                              smallButton(
                                isDelete: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                      // 10.verticalSpace(context)
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}

class WhatsappContainer extends StatelessWidget {
  const WhatsappContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 102, 202, 136),
            const Color.fromARGB(255, 49, 100, 46)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/icon/whatsapp_icon.png',
        ),
      ),
    );
  }
}
