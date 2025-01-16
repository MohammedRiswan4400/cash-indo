// Currency Selector Dialoge

import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        AppTextWidget(
          text: 'Select Currency',
          color: AppColor.kTextColor,
          size: 22,
          weight: FontWeight.w700,
        ),
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
