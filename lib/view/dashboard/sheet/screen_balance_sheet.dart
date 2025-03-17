import 'dart:developer';

import 'package:cash_indo/controller/db/contacts_db/contact_db.dart';
import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/view/dashboard/sheet/bloc/contact_bloc.dart';
import 'package:cash_indo/view/dashboard/sheet/widgets/sheet_widgets.dart';
import 'package:cash_indo/widget/appbar_widget.dart';
import 'package:cash_indo/widget/balance_sheet_widgets.dart';
import 'package:cash_indo/widget/dialoge_boxes.dart';
import 'package:cash_indo/widget/helper/snack_bar_helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:get/get.dart';

// final ContactBloc contactBloc = ContactBloc();

class ScreenBalanceSheet extends StatelessWidget {
  ScreenBalanceSheet({super.key});

  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();

  final ValueNotifier<List<Contact>> contactsNotifier = ValueNotifier([]);
  @override
  Widget build(BuildContext context) {
    // context.read<ContactBloc>();
    // context.read<ContactBloc>().add(FetchContactsEvent());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConst.DashboardScreensHorizontalPadding,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarWidget(title: AppConstantStrings.balanceSheet),
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
                    BlocConsumer<ContactBloc, ContactState>(
                      bloc: context.read<ContactBloc>(),
                      listenWhen: (previous, current) =>
                          current is ContactActionState,
                      buildWhen: (previous, current) =>
                          current is! ContactActionState,
                      listener: (context, state) {
                        if (state is ShowContactSnackbar) {
                          SnackBarHelper.snackBarFaild('Oops!', state.message);
                        }
                      },
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case const (ContactLoaded):
                            final loadedState = state as ContactLoaded;

                            if (loadedState.contacts.isEmpty) {
                              return const Center(
                                child: Text("No contacts found on your DB"),
                              );
                            }

                            final contacts = loadedState.contacts;
                            return ListView.separated(
                              physics: BouncingScrollPhysics(),
                              separatorBuilder: (context, index) => Divider(),
                              shrinkWrap: true,
                              itemCount: contacts.length,
                              itemBuilder: (context, index) {
                                final contact = contacts[index];
                                return GestureDetector(
                                  onTap: () {
                                    AppRoutes.gotoScreenUserTransaction(
                                        false, contact);
                                  },
                                  onLongPress: () {
                                    Get.dialog(
                                      Dialog(
                                        backgroundColor: Colors.black,
                                        shape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: DeleteDialogeBox(
                                          deleteWhat: 'Contact',
                                          ontap: () {
                                            ContactDb.deleteContact(
                                                context, contact.id!);
                                          },
                                        ),
                                      ),
                                    );
                                    // ContactDb.deleteContact(
                                    //     context, contact.id!);
                                  },
                                  child: UserListTile(
                                    contactModel: contact,
                                  ),
                                );
                              },
                            );

                          case const (ContactLoading):
                            return ContactLoadingWidget();

                          case const (ContactError):
                            // final errorState = state as ContactError;
                            return ContactLoadingWidget();
                          default:
                            return const Center(
                                child: Text("No contacts available"));
                        }
                      },
                    ),
                    // BlocConsumer<ContactBloc, ContactState>(
                    //   listener: (context, state) {
                    //     if (state is ContactError) {
                    //       SnackBarHelper.snackBarFaild(
                    //           'Oops!', state.errorMessage);
                    //     }
                    //   },
                    //   builder: (context, state) {
                    //     if (state is ContactLoading) {
                    //       return ContactLoadingWidget();
                    //     }

                    //     if (state is ContactError) {
                    //       return ContactLoadingWidget();
                    //     }
                    //     // if (state is ContactLoaded) {
                    //     //   return Center(
                    //     //       child: Text("No contacts Listed in your DB."));
                    //     // }
                    //     if (state is ContactLoaded) {
                    //       final contacts = state.contacts;

                    //       return ListView.separated(
                    //         physics: BouncingScrollPhysics(),
                    //         separatorBuilder: (context, index) => Padding(
                    //           padding: const EdgeInsets.all(1.0),
                    //           child: Divider(),
                    //         ),
                    //         shrinkWrap: true,
                    //         itemCount: contacts.length,
                    //         itemBuilder: (context, index) {
                    //           final contact = contacts[index];

                    //           return GestureDetector(
                    //             onTap: () {
                    //               AppRoutes.gotoScreenUserTransaction(false);
                    //             },
                    //             child: UserListTile(
                    //               contactModel: contact,
                    //             ),
                    //           );
                    //         },
                    //       );
                    //     }

                    //     return Center(child: Text("No contacts available."));
                    //   },
                    // ),
                    // StreamBuilder<List<ContactModel>>(
                    //   stream: ContactDb.readContacts(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return Center(child: CircularProgressIndicator());
                    //     }
                    //     if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    //       log(snapshot.data!.toString());
                    //       return Center(child: Text("No contacts found"));
                    //     }
                    //     List<ContactModel> contacts = snapshot.data!;
                    //     return ListView.separated(
                    //       physics: BouncingScrollPhysics(),
                    //       separatorBuilder: (context, index) => Divider(),
                    //       shrinkWrap: true,
                    //       itemCount: contacts.length,
                    //       itemBuilder: (context, index) {
                    //         final contact = contacts[index];
                    //         return GestureDetector(
                    //           onTap: () {
                    //             AppRoutes.gotoScreenUserTransaction(false);
                    //           },
                    //           child: UserListTile(
                    //             contactModel: contact,
                    //           ),
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),
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
