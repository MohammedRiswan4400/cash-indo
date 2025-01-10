import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts_const.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/buttons.dart';
import 'package:cash_indo/widget/form_fields.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

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
              AppTextWidget(text: AppTextsConst.welcomeBack, size: 30),
              AppTextWidget(
                text: AppTextsConst.loginSubTitle,
                size: 18,
                weight: FontWeight.w700,
              ),
              0.verticalSpace,
              AppTextWidget(
                  text: AppTextsConst.emailText,
                  size: 16,
                  weight: FontWeight.w700),
              EmailTextFormField(
                action: TextInputAction.next,
                controller: TextEditingController(),
              ),
              AppTextWidget(
                  text: AppTextsConst.password,
                  size: 16,
                  weight: FontWeight.w700),
              PasswordField(
                  action: TextInputAction.done,
                  passwoedController: TextEditingController(),
                  hintText: AppTextsConst.passwordHint),
              Align(
                  alignment: Alignment.centerRight,
                  child: AppTextWidget(
                      text: AppTextsConst.forgotPassword,
                      size: 14,
                      weight: FontWeight.w600)),
              10.verticalSpace,
              AppButton(title: AppTextsConst.login),
              5.verticalSpace,
              Center(
                  child: AppTextWidget(
                      text: AppTextsConst.or,
                      size: 14,
                      weight: FontWeight.w600)),
              5.verticalSpace,
              AppButton(title: AppTextsConst.continueWithGoogle),
              20.verticalSpace,
              Center(
                child: AppTextWidget(
                    text: AppTextsConst.youDontHaveAccount,
                    size: 12,
                    weight: FontWeight.w600),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    AppRoutes.gotoScreenSignUp();
                  },
                  child: AppTextWidget(
                      text: AppTextsConst.signUp,
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
