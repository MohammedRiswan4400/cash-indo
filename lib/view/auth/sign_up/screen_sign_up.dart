import 'package:cash_indo/controller/theme/theme_controller.dart';
import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/buttons.dart';
import 'package:cash_indo/widget/form_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final ThemeController themeController = Get.find<ThemeController>();

class ScreenSignUp extends StatelessWidget {
  ScreenSignUp({super.key});

  final ValueNotifier<bool> _isTermsAndConditionsChecked = ValueNotifier(false);
  final ValueNotifier<bool> _isPrivacyPolicyChecked = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConst.appScreenHorizontalPadding,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              AppTextWidget(text: AppConstantStrings.getStart, size: 30),
              AppTextWidget(
                text: AppConstantStrings.signUpSubTitle,
                size: 18,
                weight: FontWeight.w700,
              ),
              0.verticalSpace,
              AppTextWidget(
                  text: AppConstantStrings.emailText,
                  size: 16,
                  weight: FontWeight.w700),
              EmailTextFormField(
                action: TextInputAction.next,
                controller: TextEditingController(),
              ),
              AppTextWidget(
                  text: AppConstantStrings.password,
                  size: 16,
                  weight: FontWeight.w700),
              PasswordField(
                  action: TextInputAction.done,
                  passwoedController: TextEditingController(),
                  hintText: AppConstantStrings.passwordHint),
              AppTextWidget(
                  text: AppConstantStrings.confirmPassword,
                  size: 16,
                  weight: FontWeight.w700),
              PasswordField(
                  action: TextInputAction.done,
                  passwoedController: TextEditingController(),
                  hintText: AppConstantStrings.confirmPasswordHint),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 10,
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: _isTermsAndConditionsChecked,
                          builder: (context, value, _) {
                            return Checkbox(
                              activeColor: Colors.grey,
                              value: value,
                              onChanged: (bool? newValue) {
                                _isTermsAndConditionsChecked.value =
                                    newValue ?? false;
                              },
                            );
                          },
                        ),
                        AppTextWidget(
                            text: AppConstantStrings.iAgree,
                            size: 15,
                            weight: FontWeight.w500,
                            color: Colors.grey),
                        GestureDetector(
                          child: AppTextWidget(
                              text: 'T&C',
                              size: 16,
                              isUnderLine: true,
                              weight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 10,
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: _isPrivacyPolicyChecked,
                          builder: (context, value, _) {
                            return Checkbox(
                              activeColor: Colors.grey,
                              value: value,
                              onChanged: (bool? newValue) {
                                _isPrivacyPolicyChecked.value =
                                    newValue ?? false;
                              },
                            );
                          },
                        ),
                        AppTextWidget(
                            text: AppConstantStrings.iAgree,
                            size: 15,
                            weight: FontWeight.w500,
                            color: Colors.grey),
                        GestureDetector(
                          child: AppTextWidget(
                            text: AppConstantStrings.privacyPolicy,
                            size: 16,
                            isUnderLine: true,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _isPrivacyPolicyChecked,
                builder: (context, isPrivacyChecked, _) {
                  return ValueListenableBuilder<bool>(
                    valueListenable: _isTermsAndConditionsChecked,
                    builder: (context, isTermsChecked, _) {
                      final isButtonEnabled =
                          isPrivacyChecked && isTermsChecked;
                      return GestureDetector(
                        onTap: isButtonEnabled
                            ? () {
                                AppRoutes.gotoBottomNavigation();
                              }
                            : null,
                        child: isButtonEnabled
                            ? AppButton(title: AppConstantStrings.signUp)
                            : AppButtonDim(title: AppConstantStrings.signUp),
                      );
                    },
                  );
                },
              ),
              ElevatedButton(
                onPressed: themeController.toggleTheme,
                child: Obx(() {
                  return Text(
                    themeController.isDarkMode.value
                        ? "Switch to Light Mode"
                        : "Switch to Dark Mode",
                  );
                }),
              ),
              20.verticalSpace,
              Center(
                child: AppTextWidget(
                  text: AppConstantStrings.alreadyHaveAnAccount,
                  size: 12,
                  weight: FontWeight.w600,
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    AppRoutes.gotoScreenSignIn();
                  },
                  child: AppTextWidget(
                      text: AppConstantStrings.signIn,
                      size: 16,
                      weight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
