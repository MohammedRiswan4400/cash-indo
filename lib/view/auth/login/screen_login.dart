import 'package:cash_indo/controller/functions/auth/auth_functions.dart';
import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/buttons.dart';
import 'package:cash_indo/widget/form_fields.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});
  final signInFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConst.appScreenHorizontalPadding,
          child: Form(
            key: signInFormKey,
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                AppTextWidget(text: AppConstantStrings.welcomeBack, size: 30),
                AppTextWidget(
                  text: AppConstantStrings.loginSubTitle,
                  size: 18,
                  weight: FontWeight.w700,
                  align: TextAlign.left,
                ),
                0.verticalSpace(context),
                AppTextWidget(
                    text: AppConstantStrings.emailText,
                    size: 16,
                    weight: FontWeight.w700),
                EmailTextFormField(
                  action: TextInputAction.next,
                  controller: emailController,
                ),
                AppTextWidget(
                    text: AppConstantStrings.password,
                    size: 16,
                    weight: FontWeight.w700),
                PasswordField(
                    action: TextInputAction.done,
                    passwoedController: passwordController,
                    hintText: AppConstantStrings.passwordHint),
                Align(
                    alignment: Alignment.centerRight,
                    child: AppTextWidget(
                        text: AppConstantStrings.forgotPassword,
                        size: 14,
                        weight: FontWeight.w600)),
                0.verticalSpace(context),
                GestureDetector(
                    onTap: () {
                      if (signInFormKey.currentState?.validate() ?? false) {
                        AuthFunctions.signInWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim());
                      }
                    },
                    child: AppButton(title: AppConstantStrings.login)),
                10.verticalSpace(context),
                Center(
                  child: AppTextWidget(
                      text: AppConstantStrings.youDontHaveAccount,
                      size: 12,
                      weight: FontWeight.w600),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      AppRoutes.gotoScreenSignUp();
                    },
                    child: AppTextWidget(
                      text: AppConstantStrings.signUp,
                      size: 16,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
