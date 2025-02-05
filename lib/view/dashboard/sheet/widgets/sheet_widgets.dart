import 'dart:developer';

import 'package:cash_indo/controller/db/contacts_db/contact_db.dart';
import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/helper/shimmer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';

class AddContactWidget extends StatelessWidget {
  const AddContactWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color.fromARGB(255, 92, 36, 81)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: AppTextWidget(
          text: 'Add People +',
          size: 16,
          color: AppColor.kTextColor,
        ),
      ),
    );
  }
}

class NewContactWidget extends StatelessWidget {
  const NewContactWidget({
    super.key,
    required this.contactsNotifier,
  });

  final ValueNotifier<List<Contact>> contactsNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Contact>>(
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
                                width: MediaQuery.sizeOf(context).width / 3.3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          List.from(contacts)..remove(contact);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                          contact.phoneNumbers!.isNotEmpty) {
                                        String phoneNumber =
                                            contact.phoneNumbers!.first;
                                        ContactDb.addContact(
                                          contactsNotifier: contactsNotifier,
                                          contactModel: contact,
                                          phoneNumber: phoneNumber,
                                        );
                                      } else {
                                        log("No phone number available");
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                  // Divider(),
                  10.verticalSpace(context)
                ],
              );
            }),
          ],
        );
      },
    );
  }
}

class ContactLoadingWidget extends StatelessWidget {
  const ContactLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Row(
          spacing: 20,
          children: [
            ShimmerCircleErrorWidget(radius: 30),
            ShimmerErrorWidget(
              firstWidth: 200,
              firstHeight: 20,
              secondWidth: 150,
              secondHeight: 10,
            )
          ],
        ),
        Row(
          spacing: 20,
          children: [
            ShimmerCircleErrorWidget(radius: 30),
            ShimmerErrorWidget(
              firstWidth: 200,
              firstHeight: 20,
              secondWidth: 150,
              secondHeight: 10,
            )
          ],
        ),
      ],
    );
  }
}
