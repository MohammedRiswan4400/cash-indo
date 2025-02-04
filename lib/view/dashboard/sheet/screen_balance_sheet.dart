import 'dart:developer';

import 'package:cash_indo/controller/db/contacts_db/contact_db.dart';
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
                  child: AddContactWidget(),
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    NewContactWidget(contactsNotifier: contactsNotifier),
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
