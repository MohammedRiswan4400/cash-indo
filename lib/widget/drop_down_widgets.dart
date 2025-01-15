import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:flutter/material.dart';

class MonthDropDownWidget extends StatelessWidget {
  MonthDropDownWidget({super.key});

  final ValueNotifier<String> selectedMonthNotifier = ValueNotifier('January');

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedMonthNotifier,
      builder: (context, selectedMonth, _) {
        return Container(
          height: 55,
          width: 140,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppColor.kMonthDropDownColor,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Center(
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(10),
              dropdownColor: AppColor.kMonthDropDownColor,
              value: selectedMonth,
              icon: Icon(
                Icons.arrow_drop_down,
                color: AppColor.kTextColor,
              ),
              iconSize: 20,
              elevation: 16,
              style: TextStyle(color: Colors.black, fontSize: 16),
              underline: Container(height: 2),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedMonthNotifier.value = newValue;
                }
              },
              items: AppConstantStrings.allMonths
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: AppTextWidget(
                    text: value,
                    size: 16,
                    weight: FontWeight.bold,
                    color: AppColor.kTextColor,
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class PaymentOptionsDropDownWidget extends StatelessWidget {
  PaymentOptionsDropDownWidget({super.key});

  final ValueNotifier<String> selectedPaymentMethode = ValueNotifier('Cash');

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPaymentMethode,
      builder: (context, selectedMethode, _) {
        return Container(
          height: 40,
          width: 150,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppColor.kPaymentSelectingContainerColor,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Center(
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(10),
              dropdownColor: AppColor.kPaymentSelectingContainerColor,
              value: selectedMethode,
              padding: EdgeInsets.zero,
              isDense: true,
              alignment: Alignment.center,
              icon: SizedBox.shrink(),
              underline: SizedBox(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedPaymentMethode.value = newValue;
                }
              },
              items: AppConstantStrings.paymentMedthods
                  .map<DropdownMenuItem<String>>((Map<String, String> method) {
                final String image = method.keys.first;
                final String name = method.values.first;
                return DropdownMenuItem<String>(
                  value: name,
                  child: Row(
                    spacing: 10,
                    children: [
                      Image.asset(
                        image,
                        width: 20,
                        height: 20,
                        color: AppColor.kInvertedTextColor,
                        fit: BoxFit.contain,
                      ),
                      AppTextWidget(
                        text: name,
                        size: 14,
                        weight: FontWeight.bold,
                        color: AppColor.kInvertedTextColor,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class PaymentCategoryDropDownWidget extends StatelessWidget {
  PaymentCategoryDropDownWidget({super.key});

  final ValueNotifier<String> selectedCategoryNotifier = ValueNotifier('Food');

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedCategoryNotifier,
      builder: (context, selectedCategory, _) {
        return Container(
          height: 40,
          width: 160,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppColor.kPaymentCategoryContainerWidget,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Center(
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(10),
              dropdownColor: AppColor.kPaymentCategoryContainerWidget,
              value: selectedCategory,
              isDense: true,
              alignment: Alignment.center,
              icon: Icon(
                Icons.arrow_drop_down,
                color: AppColor.kInvertedTextColor,
              ),
              iconSize: 20,
              elevation: 16,
              style: TextStyle(color: Colors.black, fontSize: 16),
              underline: Container(height: 2),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedCategoryNotifier.value = newValue;
                }
              },
              items: AppConstantStrings.paymentCategory
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: AppTextWidget(
                    text: value,
                    size: 16,
                    weight: FontWeight.bold,
                    color: AppColor.kInvertedTextColor,
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class IncomeCategoryDropDownWidget extends StatelessWidget {
  IncomeCategoryDropDownWidget({super.key});

  final ValueNotifier<String> selectedPlanNotifier = ValueNotifier('Salary');

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPlanNotifier,
      builder: (context, selectedPlan, _) {
        return Container(
          height: 40,
          width: 160,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppColor.kIncomeTypeSelectingContainerColor,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Center(
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(10),
              dropdownColor: AppColor.kIncomeTypeSelectingContainerColor,
              value: selectedPlan,
              isDense: true,
              alignment: Alignment.center,
              icon: Icon(
                Icons.arrow_drop_down,
                color: AppColor.kInvertedTextColor,
              ),
              iconSize: 20,
              elevation: 16,
              style: TextStyle(color: Colors.black, fontSize: 16),
              underline: Container(height: 2),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedPlanNotifier.value = newValue;
                }
              },
              items: AppConstantStrings.incomePlans
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: AppTextWidget(
                    text: value,
                    size: 16,
                    weight: FontWeight.bold,
                    color: AppColor.kInvertedTextColor,
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
