// Currency Selector Dialoge

import 'package:cash_indo/controller/functions/auth/auth_functions.dart';
import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class LogoutDialogeBox extends StatelessWidget {
  const LogoutDialogeBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
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
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextWidget(
              text: 'Are you sure you want to log out?',
              size: 16,
              color: AppColor.kTextColor,
            ),
            // 10.verticalSpace(context),
            AppTextWidget(
              text: 'You’ll need to log in again to access your account.',
              size: 12,
              color: AppColor.kTextColor,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DialogeBoxButton(
                  size: 10,
                  textColor: AppColor.kArrowColor,
                  text: 'Cancel',
                  onTap: () {
                    AppRoutes.popNow();
                  },
                ),
                DialogeBoxButton(
                  size: 14,
                  textColor: Colors.red,
                  text: 'Log out',
                  onTap: () {
                    AuthFunctions.signOut(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DialogeBoxButton extends StatelessWidget {
  const DialogeBoxButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.size,
    required this.textColor,
  });
  final String text;
  final double size;
  final Color textColor;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: AppTextWidget(text: text, size: size, color: textColor),
          ),
        ),
      ),
    );
  }
}

class DeleteAccountDialogeBox extends StatelessWidget {
  const DeleteAccountDialogeBox({
    super.key,
    required this.user,
    required this.passwordController,
  });

  final User? user;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
              text: 'Are you sure you want to delete your account?',
              size: 16,
              align: TextAlign.left,
              color: AppColor.kTextColor,
            ),
            AppTextWidget(
              text:
                  'This action is permanent and cannot be undone. All your data will be lost.',
              size: 10,
              align: TextAlign.left,
              color: AppColor.kTextColor,
            ),
            AppTextWidget(
              text: 'Email : ${user!.email!}',
              size: 16,
              align: TextAlign.left,
              color: AppColor.kTextColor,
            ),
            PasswordField(
                action: TextInputAction.done,
                passwoedController: passwordController,
                hintText: AppConstantStrings.passwordHint),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DialogeBoxButton(
                  size: 10,
                  textColor: AppColor.kArrowColor,
                  text: 'Cancel',
                  onTap: () {
                    AppRoutes.popNow();
                  },
                ),
                DialogeBoxButton(
                  size: 14,
                  textColor: Colors.red,
                  text: 'Delete account',
                  onTap: () {
                    AuthFunctions.deleteAccount(passwordController);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
