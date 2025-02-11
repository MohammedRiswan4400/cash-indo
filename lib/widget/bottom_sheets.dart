import 'package:cash_indo/controller/db/credit_db/credit_db.dart';
import 'package:cash_indo/controller/db/expense_db/expense_db.dart';
import 'package:cash_indo/controller/db/income_db/income_db.dart';
import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/model/contact_model.dart';
import 'package:cash_indo/model/credit_model.dart';
import 'package:cash_indo/model/expense_model.dart';
import 'package:cash_indo/model/income_model.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/dialoge_boxes.dart';
import 'package:cash_indo/widget/drop_down_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MoneyKeyboardBottomSheet extends StatelessWidget {
  MoneyKeyboardBottomSheet(
      {super.key,
      required this.isExpanseSheet,
      required this.title,
      this.isTrnsactionScreen,
      this.isAmountRemoving,
      this.isIncomeSheet,
      this.thisIs,
      this.contactModel});
  final moneyFormKey = GlobalKey<FormState>();
  final bool isExpanseSheet;
  bool? isIncomeSheet;
  ContactModel? contactModel;
  final String title;
  final RxString selectedCurrency = RxString(AppConstantStrings.rupees);
  bool? isTrnsactionScreen;
  bool? isAmountRemoving;
  final TextEditingController moneyTextController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  String? thisIs;
  void _onNumberTap(String number) {
    if (number == '.' && moneyTextController.text.contains('.')) {
      return;
    }
    moneyTextController.text += number;
    moneyTextController.selection = TextSelection.fromPosition(
      TextPosition(offset: moneyTextController.text.length),
    );
  }

  void _onBackspaceTap() {
    if (moneyTextController.text.isNotEmpty) {
      moneyTextController.text = moneyTextController.text.substring(
        0,
        moneyTextController.text.length - 1,
      );
      moneyTextController.selection = TextSelection.fromPosition(
        TextPosition(offset: moneyTextController.text.length),
      );
    }
  }

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
        child: Form(
          key: moneyFormKey,
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

              isTrnsactionScreen == true
                  ? SizedBox.shrink()
                  : Row(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 75),
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
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                        hintText: '000.00',
                        hintStyle: TextStyle(
                          color: AppColor.kArrowColor,
                          fontSize: 30,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      ),
                      style: TextStyle(
                        fontSize: 30,
                        color: AppColor.kInvertedTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                      controller: moneyTextController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the amount';
                        }
                        if (value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Center(
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: commentController,
                    textAlign: TextAlign.center,
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
                          NumberButtonWidget(
                            number: '1',
                            onTap: () => _onNumberTap('1'),
                          ),
                          NumberButtonWidget(
                            number: '2',
                            onTap: () => _onNumberTap('2'),
                          ),
                          NumberButtonWidget(
                            number: '3',
                            onTap: () => _onNumberTap('3'),
                          ),
                          NumberButtonWidget(
                            number: '4',
                            onTap: () => _onNumberTap('4'),
                          ),
                          NumberButtonWidget(
                            number: '5',
                            onTap: () => _onNumberTap('5'),
                          ),
                          NumberButtonWidget(
                            number: '6',
                            onTap: () => _onNumberTap('6'),
                          ),
                          NumberButtonWidget(
                            number: '7',
                            onTap: () => _onNumberTap('7'),
                          ),
                          NumberButtonWidget(
                            number: '8',
                            onTap: () => _onNumberTap('8'),
                          ),
                          NumberButtonWidget(
                            number: '9',
                            onTap: () => _onNumberTap('9'),
                          ),
                          NumberButtonWidget(
                            number: '.',
                            onTap: () => _onNumberTap('.'),
                          ),
                          NumberButtonWidget(
                            number: '0',
                            onTap: () => _onNumberTap('0'),
                          ),
                          NumberButtonWidget(
                            onTap: () {
                              AppRoutes.popNow();
                            },
                            icon: Icons.close,
                            isNumber: false,
                            color: const Color.fromARGB(255, 255, 105, 105),
                          ),
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
                            onTap: () {
                              _onBackspaceTap();
                            },
                            icon: Icons.backspace_outlined,
                            isNumber: false,
                            color: const Color.fromARGB(255, 250, 169, 169),
                            cWidth: MediaQuery.sizeOf(context).width / 4.6,
                            cHeight: MediaQuery.sizeOf(context).width / 4.4,
                          ),
                          Obx(
                            () => NumberButtonWidget(
                              onTap: () {
                                Get.defaultDialog(
                                  backgroundColor: AppColor.kBackgroundColor,
                                  title: AppConstantStrings.selectCurrency,
                                  content: CurrencySelectingDialog(
                                      selectedCurrency: selectedCurrency),
                                );
                              },
                              icon: Icons.date_range,
                              number: selectedCurrency.value,
                              color: const Color.fromARGB(255, 251, 214, 171),
                              cWidth: MediaQuery.sizeOf(context).width / 4.6,
                              cHeight: MediaQuery.sizeOf(context).width / 4.4,
                            ),
                          ),
                          NumberButtonWidget(
                            onTap: () {
                              if (moneyFormKey.currentState?.validate() ??
                                  false) {
                                final amount = moneyTextController.text.trim();
                                final comment = commentController.text.trim();

                                if (isIncomeSheet != null &&
                                    isIncomeSheet == true) {
                                  IncomeDb.addIncome(
                                    context: context,
                                    incomeModel: IncomeModel(
                                      // today: '',
                                      comment: comment,
                                      currency: selectedCurrency.value,
                                      amount: double.parse(amount),
                                      category:
                                          selectedIncomePlanNotifier.value,
                                      createdAt: DateTime.now(),
                                    ),
                                  );
                                } else if (isExpanseSheet == true) {
                                  ExpenseDb.addExpense(
                                    context: context,
                                    expenseModel: ExpenseModel(
                                      paymentMethode:
                                          selectedPaymentMethodeNotifier.value,
                                      comment: comment,
                                      currency: selectedCurrency.value,
                                      amount: double.parse(amount),
                                      category: selectedCategoryNotifier.value,
                                      createdAt: DateTime.now(),
                                    ),
                                  );
                                } else if (thisIs != null &&
                                    thisIs == 'Credit') {
                                  CreditDb.addCredit(
                                    creditModel: CreditModel(
                                      contactName: contactModel!.name,
                                      contactPhone: contactModel!.phoneNumber,
                                      amount: double.parse(amount),
                                      comment: comment,
                                      currency: selectedCurrency.value,
                                      // isSend: false,
                                    ),
                                  );
                                }
                              }
                            },
                            icon: Icons.check,
                            isNumber: false,
                            iconColor: AppColor.kTextColor,
                            color: isTrnsactionScreen == true
                                ? isAmountRemoving == true
                                    ? AppColor.kAddingButtonColor
                                    : AppColor.kRemovingButtonColor
                                : AppColor.kBackgroundColor,
                            cWidth: MediaQuery.sizeOf(context).width / 4.6,
                            cHeight: MediaQuery.sizeOf(context).width / 2.1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // 5 .verticalSpace(context),
            ],
          ),
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
    this.onTap,
  });
  String? number;
  IconData? icon;
  bool? isNumber;
  Color? color;
  double? cHeight;
  Color? iconColor;
  double? cWidth;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
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
      ),
    );
  }
}
