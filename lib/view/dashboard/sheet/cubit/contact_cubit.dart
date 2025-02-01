import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';

class ContactState {
  final List<Contact> contacts;

  ContactState({required this.contacts});
}

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactState(contacts: []));

  void addContact(String name, String phoneNumber) {
    final newContact =
        Contact(fullName: name, selectedPhoneNumber: phoneNumber);
    final updatedContacts = List<Contact>.from(state.contacts)..add(newContact);
    emit(ContactState(contacts: updatedContacts));
  }

  void removeContact(Contact contact) {
    final updatedContacts = List<Contact>.from(state.contacts)..remove(contact);
    emit(ContactState(contacts: updatedContacts));
  }
}
