import 'dart:developer';

import 'package:cash_indo/controller/db/contacts_db/contact_db.dart';
import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/model/contact_model.dart';
import 'package:cash_indo/view/dashboard/sheet/widgets/sheet_widgets.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/balance_sheet_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';

class ScreenBalanceSheet extends StatelessWidget {
  ScreenBalanceSheet({super.key});

  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();

  final ValueNotifier<List<Contact>> contactsNotifier = ValueNotifier([]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConst.DashboardScreensHorizontalPadding,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(text: AppConstantStrings.balanceSheet),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: () async {
                      fetchContacts();
                    },
                    child: AddContactWidget()),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    ValueListenableBuilder<List<Contact>>(
                      valueListenable: contactsNotifier,
                      builder: (context, contacts, _) {
                        if (contacts.isEmpty) {
                          return SizedBox();
                        }
                        return Column(
                          children: [
                            ...contacts.map((contact) {
                              String firstLetter = contact.fullName!.isNotEmpty
                                  ? contact.fullName!.substring(0, 1)
                                  : "";
                              return Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(width: 0.2),
                                      color: AppColor.kMainContainerColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            spacing: 10,
                                            children: [
                                              CircleAvatar(
                                                  radius: 25,
                                                  child: AppTextWidget(
                                                      text: firstLetter)),
                                              SizedBox(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width /
                                                        3.3,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AppTextWidget(
                                                      align: TextAlign.start,
                                                      text: contact.fullName ??
                                                          'No name',
                                                      maxLine: 2,
                                                      size: 17,
                                                    ),
                                                    ...?contact.phoneNumbers
                                                        ?.map(
                                                      (number) => AppTextWidget(
                                                        text: number,
                                                        align: TextAlign.start,
                                                        size: 15,
                                                        maxLine: 1,
                                                        weight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              Row(
                                                spacing: 5,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      contactsNotifier.value =
                                                          List.from(contacts)
                                                            ..remove(contact);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: AppColor
                                                            .kContainerColor,
                                                        border: Border.all(
                                                            width: 0.5),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            offset:
                                                                Offset(1, 5),
                                                            blurRadius: 10,
                                                            spreadRadius: 0,
                                                            color: AppColor
                                                                .kshadowColor,
                                                          )
                                                        ],
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        child: AppTextWidget(
                                                          text: 'Cancel',
                                                          size: 13,
                                                          weight:
                                                              FontWeight.w600,
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 42, 42, 42),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (contact.phoneNumbers !=
                                                              null &&
                                                          contact.phoneNumbers!
                                                              .isNotEmpty) {
                                                        String phoneNumber =
                                                            contact
                                                                .phoneNumbers!
                                                                .first;
                                                        ContactDb.addContact(
                                                          contactsNotifier:
                                                              contactsNotifier,
                                                          contactModel: contact,
                                                          phoneNumber:
                                                              phoneNumber,
                                                        );
                                                      } else {
                                                        log("No phone number available");
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: AppColor
                                                            .kContainerColor,
                                                        border: Border.all(
                                                            width: 0.5),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            offset:
                                                                Offset(1, 5),
                                                            blurRadius: 10,
                                                            spreadRadius: 0,
                                                            color: AppColor
                                                                .kshadowColor,
                                                          )
                                                        ],
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        child: AppTextWidget(
                                                            text: 'Save',
                                                            size: 18,
                                                            weight:
                                                                FontWeight.w600,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                35, 121, 36)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Divider(),
                                  10.verticalSpace(context)
                                ],
                              );
                            }),
                          ],
                        );
                      },
                    ),
                    // StreamBuilder<List<ContactModel>>(
                    //   stream: ContactDb.streamContacts(),
                    //   builder: (context, snapshot) {
                    //     try {
                    //       if (snapshot.connectionState ==
                    //           ConnectionState.waiting) {
                    //         return const Center(
                    //             child: CircularProgressIndicator());
                    //       } else if (snapshot.hasError) {
                    //         return Center(
                    //           child: Text(
                    //             'Error loading contacts: ${snapshot.error}',
                    //             style: const TextStyle(color: Colors.red),
                    //           ),
                    //         );
                    //       } else if (!snapshot.hasData ||
                    //           snapshot.data!.isEmpty) {
                    //         return Center(
                    //             child: AppTextWidget(
                    //           text: 'No cards found\n Create your on Cards',
                    //           // color: ,
                    //           size: 18,
                    //         ));
                    //       } else {
                    //         // final contacts = snapshot.data!;
                    //         List<ContactModel> contacts = snapshot.data!;
                    //         return ListView.separated(
                    //           physics: BouncingScrollPhysics(),
                    //           separatorBuilder: (context, index) => Divider(),
                    //           shrinkWrap: true,
                    //           itemCount: contacts.length,
                    //           itemBuilder: (context, index) {
                    //             final contact = contacts[index];
                    //             return GestureDetector(
                    //                 onTap: () {
                    //                   AppRoutes.gotoScreenUserTransaction(
                    //                       false);
                    //                 },
                    //                 child: UserListTile(
                    //                   contactModel: contact,
                    //                 ));
                    //           },
                    //         );
                    //       }
                    //     } on FirebaseAuthException catch (e) {
                    //       DailogHelper.shoeErrorDailog(description: e.message);
                    //       return const Center(
                    //           child: Text('Authentication Error.'));
                    //     } catch (e) {
                    //       DailogHelper.shoeErrorDailog(
                    //           description: "An unknown error occurred: $e");
                    //       return const Center(
                    //           child: Text('Something went wrong.'));
                    //     }
                    //   },
                    // ),
                    StreamBuilder<List<ContactModel>>(
                      stream: ContactDb.readContacts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          log(snapshot.data!.toString());
                          return Center(child: Text("No contacts found"));
                        }

                        List<ContactModel> contacts = snapshot.data!;

                        return ListView.separated(
                          physics: BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => Divider(),
                          shrinkWrap: true,
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            final contact = contacts[index];
                            return GestureDetector(
                              onTap: () {
                                AppRoutes.gotoScreenUserTransaction(false);
                              },
                              child: UserListTile(
                                contactModel: contact,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    10.verticalSpace(context)
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  Future<void> fetchContacts() async {
    List<Contact> contacts = [];

    try {
      Contact? contact = await _contactPicker.selectContact();

      if (contact != null) {
        contacts.add(contact);
        contactsNotifier.value = contacts;
      }
    } catch (e) {
      log("Error fetching contacts: $e");
    }
  }
}
