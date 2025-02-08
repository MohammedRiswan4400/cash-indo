import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/model/contact_model.dart';
import 'package:cash_indo/view/dashboard/user_transaction/widgets/user_transaction_widgets.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/bottom_sheets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    super.key,
    required this.contactModel,
  });
  final ContactModel contactModel;
  @override
  Widget build(BuildContext context) {
    String firstLetter =
        contactModel.name.isNotEmpty ? contactModel.name.substring(0, 2) : "";
    return Row(
      spacing: 10,
      children: [
        CircleAvatar(radius: 25, child: AppTextWidget(text: firstLetter)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextWidget(
              text: contactModel.name,
              size: 17,
            ),
            AppTextWidget(
              text: contactModel.phoneNumber,
              size: 15,
              weight: FontWeight.normal,
            ),
          ],
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios_rounded)
      ],
    );
  }
}

///
///

class LiabilitiesAddingWidget extends StatelessWidget {
  const LiabilitiesAddingWidget({
    super.key,
    required this.text,
    required this.isDebt,
  });
  final String text;
  final bool isDebt;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 2,
      left: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Get.bottomSheet(
                MoneyKeyboardBottomSheet(
                  isExpanseSheet: true,
                  isTrnsactionScreen: true,
                  title: AppConstantStrings.expenses,
                  isAmountRemoving: isDebt ? true : false,
                ),
                isDismissible: true,
                enableDrag: true,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
              );
            },
            child: TransactionScreenButton(
                isDebt: isDebt,
                icon: AppConstantStrings.minaze,
                isDecreasing: true),
          ),
          TransactionScreenDebtOrCreditCard(
            text: text,
          ),
          GestureDetector(
            onTap: () {
              Get.bottomSheet(
                MoneyKeyboardBottomSheet(
                  isExpanseSheet: true,
                  isTrnsactionScreen: true,
                  title: AppConstantStrings.expenses,
                  isAmountRemoving: isDebt ? false : true,
                ),
                isDismissible: true,
                enableDrag: true,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
              );
            },
            child: TransactionScreenButton(
              isDebt: isDebt,
              icon: AppConstantStrings.plus,
              isDecreasing: false,
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionScreenButton extends StatelessWidget {
  const TransactionScreenButton({
    super.key,
    required this.icon,
    required this.isDecreasing,
    required this.isDebt,
  });
  final String icon;
  final bool isDecreasing;
  final bool isDebt;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isDebt
              ? isDecreasing
                  ? AppColor.kAddingButtonColor
                  : AppColor.kRemovingButtonColor
              : !isDecreasing
                  ? AppColor.kAddingButtonColor
                  : AppColor.kRemovingButtonColor),
      child: Center(
        child: AppTextWidget(
          text: icon,
          color: AppColor.kInvertedTextColor,
        ),
      ),
    );
  }
}
