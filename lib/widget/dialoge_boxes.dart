// Currency Selector Dialoge

import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'form_fields.dart';

class CurrencySelectingDialog extends StatelessWidget {
  const CurrencySelectingDialog({
    super.key,
    required this.selectedCurrency,
  });

  final RxString selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/money_list.png'),
        10.verticalSpace(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            spacing: 5,
            mainAxisSize: MainAxisSize.min,
            children: AppConstantStrings.currencies.map((currency) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 251, 214, 171),
                ),
                child: ListTile(
                  leading: AppTextWidget(
                    text: currency['icon']!,
                    color: AppColor.kInvertedTextColor,
                    size: 20,
                    weight: FontWeight.w600,
                  ),
                  title: AppTextWidget(
                    text: currency['name']!,
                    color: AppColor.kInvertedTextColor,
                    size: 18,
                    weight: FontWeight.w600,
                  ),
                  onTap: () {
                    selectedCurrency.value = currency['icon']!;
                    Get.back();
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// Saving screen

// ignore: must_be_immutable
class SavingsAmountAddingDialoge extends StatelessWidget {
  SavingsAmountAddingDialoge({super.key, required this.isAdding, this.title});
  final bool isAdding;
  String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isAdding ? 230 : 180,
      width: MediaQuery.sizeOf(context).width / 1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 58, 58, 58),
            const Color.fromARGB(255, 32, 32, 32)
          ],
          end: Alignment.bottomLeft,
          begin: Alignment.topRight,
        ),
        border: Border.all(width: 0.5),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 5),
            blurRadius: 10,
            spreadRadius: 0,
            color: AppColor.kshadowColor,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextWidget(
              text: title ?? 'Plan Your Savings',
              size: 16,
              color: AppColor.kTextColor,
            ),
            10.verticalSpace(context),
            isAdding
                ? SizedBox(
                    height: 50,
                    child: CustomeTextFormField(
                        controller: TextEditingController(),
                        hintText: 'Type your goal here'),
                  )
                : SizedBox(),
            10.verticalSpace(context),
            SizedBox(
              height: 50,
              child: CustomeTextFormField(
                  controller: TextEditingController(),
                  hintText: 'Specify the amount'),
            ),
            20.verticalSpace(context),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColor.kContainerColor,
                  border: Border.all(width: 0.5),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1, 5),
                      blurRadius: 10,
                      spreadRadius: 0,
                      color: AppColor.kshadowColor,
                    )
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: AppTextWidget(
                    text: isAdding ? 'Set Goal' : 'Save Plan',
                    size: 14,
                    color: AppColor.kInvertedTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
