import 'package:cash_indo/controller/functions/auth/auth_functions.dart';
import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/view/auth/sign_up/screen_sign_up.dart';
import 'package:cash_indo/view/dashboard/settings/widgets/settings_widgets.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/dialoge_boxes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
                            onTap: () {
                              Get.dialog(Dialog(
                                backgroundColor: Colors.black,
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Container(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Column(
                                      spacing: 5,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppTextWidget(
                                          text:
                                              'Are you sure you want to log out?',
                                          size: 16,
                                          color: AppColor.kTextColor,
                                        ),
                                        // 10.verticalSpace(context),
                                        AppTextWidget(
                                          text:
                                              'You’ll need to log in again to access your account.',
                                          size: 12,
                                          color: AppColor.kTextColor,
                                        ),
                                        DialogeBoxButton(
                                          size: 14,
                                          textColor: Colors.red,
                                          text: 'Log out',
                                          onTap: () {
                                            AuthFunctions.signOut(context);
                                          },
                                        ),
                                        DialogeBoxButton(
                                          size: 10,
                                          textColor: AppColor.kArrowColor,
                                          text: 'Cancel',
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                            },
                            text: AppConstantStrings.logOut,
                            isIcon: false,
                            textColor: Colors.orange),
                        0.verticalSpace(context),
                        SettingsTile(
                          text: AppConstantStrings.deleteAccount,
                          isIcon: false,
                          textColor: Colors.red,
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
