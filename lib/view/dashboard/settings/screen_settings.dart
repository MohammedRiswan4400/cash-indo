import 'package:cash_indo/controller/db/user_db/user_db.dart';
import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/model/user_model.dart';
import 'package:cash_indo/view/auth/sign_up/screen_sign_up.dart';
import 'package:cash_indo/view/dashboard/settings/widgets/settings_widgets.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/appbar_widget.dart';
import 'package:cash_indo/widget/dialoge_boxes.dart';
import 'package:cash_indo/widget/helper/shimmer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  AppBarWidget(title: AppConstantStrings.settings),
                  Expanded(
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        0.verticalSpace(context),
                        StreamBuilder<UserModel?>(
                          stream: UserDb.getUserByEmail(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Row(
                                spacing: 10,
                                children: [
                                  ShimmerCircleErrorWidget(radius: 30),
                                  ShimmerErrorWidget(
                                    firstHeight: 20,
                                    firstWidth: 200,
                                    secondHeight: 15,
                                    secondWidth: 150,
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Row(
                                spacing: 10,
                                children: [
                                  ShimmerCircleErrorWidget(radius: 30),
                                  ShimmerErrorWidget(
                                    firstHeight: 20,
                                    firstWidth: 200,
                                    secondHeight: 15,
                                    secondWidth: 150,
                                  ),
                                ],
                              );
                            }
                            if (!snapshot.hasData || snapshot.data == null) {
                              return Row(
                                spacing: 10,
                                children: [
                                  ShimmerCircleErrorWidget(radius: 30),
                                  ShimmerErrorWidget(
                                    firstHeight: 20,
                                    firstWidth: 200,
                                    secondHeight: 15,
                                    secondWidth: 150,
                                  ),
                                ],
                              );
                            }
                            UserModel user = snapshot.data!;
                            String name = user.name;
                            String phoneNumber = user.phoneNumber;
                            String firstLetter =
                                name.isNotEmpty ? name.substring(0, 1) : "";
                            return Row(
                              spacing: 10,
                              children: [
                                CircleAvatar(
                                    radius: 30,
                                    child: AppTextWidget(text: firstLetter)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextWidget(
                                      text: name,
                                      size: 18,
                                    ),
                                    AppTextWidget(
                                      text: phoneNumber,
                                      size: 15,
                                      weight: FontWeight.normal,
                                    ),
                                  ],
                                ),
                                // Spacer(),
                                // Icon(Icons.edit_outlined),
                              ],
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTextWidget(
                              text: AppConstantStrings.darkMode,
                              size: 18,
                            ),
                            SizedBox(width: 10),
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
                        // ElevatedButton(
                        //   onPressed: () {
                        //     log(UserDb.supaUID.toString());
                        //   },
                        //   child: Text('data'),
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
