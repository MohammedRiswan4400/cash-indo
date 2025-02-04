import 'package:cash_indo/controller/db/user_db/user_db.dart';
import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/model/user_model.dart';
import 'package:cash_indo/view/auth/sign_up/screen_sign_up.dart';
import 'package:cash_indo/view/dashboard/settings/widgets/settings_widgets.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/dialoge_boxes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
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
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        0.verticalSpace(context),
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
                        SettingsTile(
                          text: AppConstantStrings.tAndC,
                          isIcon: true,
                        ),
                        SettingsTile(
                          text: AppConstantStrings.changePassword,
                          isIcon: true,
                        ),
                        SettingsTile(
                            onTap: () {
                              Get.dialog(Dialog(
                                backgroundColor: Colors.black,
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: LogoutDialogeBox(),
                              ));
                            },
                            text: AppConstantStrings.logOut,
                            isIcon: false,
                            textColor: Colors.orange),

                        ElevatedButton(
                            onPressed: () {
                              UserDb.createUserProfile(UserModel(
                                // id: 1,
                                name: 'John Doe',
                                email: 'johndoe@example.com',
                                phoneNumber: '1234567890',
                              ));
                            },
                            child: Text('data'))
                        // SettingsTile(
                        //   onTap: () {
                        //     // user!.email != null
                        //     //     ?
                        //     Get.dialog(Dialog(
                        //       backgroundColor: Colors.black,
                        //       shape: ContinuousRectangleBorder(
                        //         borderRadius: BorderRadius.circular(30),
                        //       ),
                        //       child: DeleteAccountDialogeBox(),
                        //     ));
                        //     // : null;
                        //   },
                        //   text: AppConstantStrings.deleteAccount,
                        //   isIcon: false,
                        //   textColor: Colors.red,
                        // ),
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
