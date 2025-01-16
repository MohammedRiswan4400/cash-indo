import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/view/auth/sign_up/screen_sign_up.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return SafeArea(
            child: Padding(
              padding: AppConst.DashboardScreensHorizontalPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(text: AppConstantStrings.settings),
                  Expanded(
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.verticalSpace(context),
                        Row(
                          spacing: 10,
                          children: [
                            CircleAvatar(
                                radius: 30, child: AppTextWidget(text: 'R')),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextWidget(
                                  text: 'Riswan',
                                  size: 18,
                                ),
                                AppTextWidget(
                                  text: '+91 8138874400',
                                  size: 15,
                                  weight: FontWeight.normal,
                                ),
                              ],
                            ),
                            Spacer(),
                            Icon(Icons.edit_outlined),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTextWidget(
                              text: AppConstantStrings.darkMode,
                              size: 18,
                            ),

                            SizedBox(
                                width: 10), // Space between text and switch
                            Switch(
                              value: themeController.isDarkMode.value,
                              onChanged: (value) {
                                themeController.toggleTheme();
                              },
                              activeColor: Colors.green,
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.grey[300],
                            ),
                          ],
                        ),
                        SettingsTile(
                          text: AppConstantStrings.privacyPolicy,
                          isIcon: true,
                        ),
                        0.verticalSpace(context),
                        SettingsTile(
                          text: AppConstantStrings.tAndC,
                          isIcon: true,
                        ),
                        0.verticalSpace(context),
                        SettingsTile(
                          text: AppConstantStrings.changePassword,
                          isIcon: true,
                        ),
                        0.verticalSpace(context),
                        SettingsTile(
                          text: AppConstantStrings.logOut,
                          isIcon: false,
                          textColor: const Color.fromARGB(255, 255, 94, 0),
                        ),
                        0.verticalSpace(context),
                        SettingsTile(
                          text: AppConstantStrings.deleteAccount,
                          isIcon: false,
                          textColor: const Color.fromARGB(255, 255, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class SettingsTile extends StatelessWidget {
  SettingsTile({
    super.key,
    required this.text,
    this.textColor,
    required this.isIcon,
  });
  final String text;
  Color? textColor;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextWidget(
          text: text, size: 18, // ignore: unnecessary_null_in_if_null_operators
          color: textColor ?? null,
        ),
        isIcon
            ? Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              )
            : SizedBox()
      ],
    );
  }
}
