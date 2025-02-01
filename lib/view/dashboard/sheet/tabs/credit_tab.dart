import 'dart:developer';
import 'package:cash_indo/controller/functions/app_functions/app_functions.dart';
import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/view/dashboard/sheet/widgets/sheet_widgets.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/balance_sheet_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';

List<Contact>? contacts;

class CreditTab extends StatelessWidget {
  CreditTab({
    super.key,
  });

  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();

  final ValueNotifier<List<Contact>> contactsNotifier = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(spacing: 10, children: [
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
              onTap: () async {
                fetchContacts();
              },
              child: AddContactWidget()),
        ),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                spacing: 10,
                                children: [
                                  CircleAvatar(
                                      radius: 25,
                                      child: AppTextWidget(text: firstLetter)),
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width / 3.3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppTextWidget(
                                          align: TextAlign.start,
                                          text: contact.fullName ?? 'No name',
                                          maxLine: 2,
                                          size: 17,
                                        ),
                                        ...?contact.phoneNumbers?.map(
                                          (number) => AppTextWidget(
                                            text: number,
                                            align: TextAlign.start,
                                            size: 15,
                                            maxLine: 1,
                                            weight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    spacing: 5,
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                                BorderRadius.circular(10),
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: AppTextWidget(
                                              text: 'Cancel',
                                              size: 13,
                                              weight: FontWeight.w600,
                                              color: const Color.fromARGB(
                                                  255, 42, 42, 42),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (contact.phoneNumbers != null &&
                                              contact
                                                  .phoneNumbers!.isNotEmpty) {
                                            String phoneNumber =
                                                contact.phoneNumbers!.first;

                                            AppFunctions.addContact(
                                              contactsNotifier:
                                                  contactsNotifier,
                                              contactModel: contact,
                                              phoneNumber: phoneNumber,
                                            );
                                          } else {
                                            log("No phone number available");
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: AppTextWidget(
                                                text: 'Save',
                                                size: 18,
                                                weight: FontWeight.w600,
                                                color: const Color.fromARGB(
                                                    255, 35, 121, 36)),
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
                      Divider(),
                      10.verticalSpace(context)
                    ],
                  );
                }),
              ],
            );
          },
        ),
        ListView.separated(
          physics: BouncingScrollPhysics(),
          separatorBuilder: (context, index) => Divider(),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  AppRoutes.gotoScreenUserTransaction(false);
                },
                child: UserListTile());
          },
        )
      ]),
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
      print("Error fetching contacts: $e");
    }
  }
}

// Future<bool> requestContactsPermission() async {
//   var status = await Permission.contacts.request();
//   return status.isGranted;
// }
