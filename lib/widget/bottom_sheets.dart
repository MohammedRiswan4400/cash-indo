import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/dialoge_boxes.dart';
import 'package:cash_indo/widget/drop_down_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoneyKeyboardBottomSheet extends StatelessWidget {
  MoneyKeyboardBottomSheet({
    super.key,
    required this.isExpanseSheet,
    required this.title,
  });
  final bool isExpanseSheet;
  final String title;
  final RxString selectedCurrency = RxString(AppConstantStrings.rupees);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.kSecondaryTextColor,
              ),
            ),
            10.verticalSpace(context),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: isExpanseSheet
                  ? [
                      PaymentOptionsDropDownWidget(),
                      PaymentCategoryDropDownWidget(),
                    ]
                  : [
                      IncomeCategoryDropDownWidget(),
                    ],
            ),

            10.verticalSpace(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextWidget(
                    text: AppConstantStrings.today,
                    size: 18,
                    weight: FontWeight.w700,
                    color: AppColor.todayColor
                    // const
                    ),
                AppTextWidget(
                  text: title,
                  size: 12,
                  weight: FontWeight.w400,
                  color: AppColor.kInvertedTextColor,
                ),
                SizedBox(
                  width: 60,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: AppTextWidget(
                      text: selectedCurrency.value,
                      size: 20,
                      weight: FontWeight.w600,
                      color: AppColor.kInvertedTextColor,
                    ),
                  ),
                ),
                AppTextWidget(
                  text: AppConstantStrings.constantAmount,
                  size: 30,
                  weight: FontWeight.w600,
                  color: AppColor.kInvertedTextColor,
                ),
              ],
            ),
            Center(
              child: SizedBox(
                width: 150,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: AppConstantStrings.addComment,
                    hintStyle: TextStyle(
                      color: AppColor.kArrowColor,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
            5.verticalSpace(context),
            SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 1.4,
                    child: GridView(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      children: [
                        NumberButtonWidget(number: '1'),
                        NumberButtonWidget(number: '2'),
                        NumberButtonWidget(number: '3'),
                        NumberButtonWidget(number: '4'),
                        NumberButtonWidget(number: '5'),
                        NumberButtonWidget(number: '6'),
                        NumberButtonWidget(number: '7'),
                        NumberButtonWidget(number: '8'),
                        NumberButtonWidget(number: '9'),
                        NumberButtonWidget(number: '.'),
                        NumberButtonWidget(number: '0'),
                        NumberButtonWidget(number: ','),
                      ],
                    ),
                  ),
                  SizedBox(
                    // color: Colors.cyanAccent,
                    width: MediaQuery.sizeOf(context).width / 4.6,
                    child: Column(
                      spacing: 5,
                      children: [
                        NumberButtonWidget(
                          icon: Icons.backspace_outlined,
                          isNumber: false,
                          color: const Color.fromARGB(255, 250, 169, 169),
                          cWidth: MediaQuery.sizeOf(context).width / 4.6,
                          cHeight: MediaQuery.sizeOf(context).width / 4.4,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                              backgroundColor: AppColor.kBackgroundColor,
                              title: '',
                              content: CurrencySelectingDialog(
                                  selectedCurrency: selectedCurrency),
                            );
                          },
                          child: Obx(
                            () => NumberButtonWidget(
                              icon: Icons.date_range,
                              number: selectedCurrency.value,
                              color: const Color.fromARGB(255, 251, 214, 171),
                              cWidth: MediaQuery.sizeOf(context).width / 4.6,
                              cHeight: MediaQuery.sizeOf(context).width / 4.4,
                            ),
                          ),
                        ),
                        NumberButtonWidget(
                          icon: Icons.check,
                          isNumber: false,
                          iconColor: AppColor.kTextColor,
                          color: AppColor.kBackgroundColor,
                          cWidth: MediaQuery.sizeOf(context).width / 4.6,
                          cHeight: MediaQuery.sizeOf(context).width / 2.1,
                        ),
                      ],
                    ),
                  ),

                  // SizedBox(
                  //   child:
                  // GridView(
                  //     physics: BouncingScrollPhysics(),
                  //     shrinkWrap: true,
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 1,
                  //         crossAxisSpacing: 0,
                  //         mainAxisSpacing: 5),
                  //     children: [
                  //       NumberButtonWidget(
                  //         icon: Icons.date_range,
                  //         isNumber: false,
                  //         color: const Color.fromARGB(255, 251, 214, 171),
                  //       ),
                  //       NumberButtonWidget(
                  //         icon: Icons.check,
                  //         isNumber: false,
                  //         cHeight: 170,
                  //         iconColor: AppColor.kTextColor,
                  //         color: AppColor.kBackgroundColor,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            // 5 .verticalSpace(context),
          ],
        ),
      ),
    );
  }
}

// Number Button Widget ---------

// ignore: must_be_immutable
class NumberButtonWidget extends StatelessWidget {
  NumberButtonWidget({
    super.key,
    this.icon,
    this.isNumber,
    this.number,
    this.color,
    this.cHeight,
    this.iconColor,
    this.cWidth,
  });
  String? number;
  IconData? icon;
  bool? isNumber;
  Color? color;
  double? cHeight;
  Color? iconColor;
  double? cWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: cHeight ?? 80,
      width: cWidth ?? 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color ?? AppColor.kContainerColor),
      child: Center(
        child: isNumber == false
            ? Icon(
                icon,
                color: iconColor ?? AppColor.kInvertedTextColor,
              )
            : AppTextWidget(
                text: number ?? '',
                color: AppColor.kInvertedTextColor,
                size: 30,
                weight: FontWeight.w600,
              ),
      ),
    );
  }
}
