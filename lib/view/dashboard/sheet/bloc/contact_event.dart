part of 'contact_bloc.dart';

// Base event class for ContactBloc
abstract class ContactEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// 🔹 Event to fetch contacts
class FetchContactsEvent extends ContactEvent {}

// 🔹 Event to update contacts when new data arrives
class ContactUpdatedEvent extends ContactEvent {
  final List<ContactModel> contacts;

  ContactUpdatedEvent(this.contacts);

  @override
  List<Object?> get props => [contacts];
}

// 🔹 Event to show a snackbar (One-time action)
class TriggerSnackbarEvent extends ContactEvent {
  final String message;

  TriggerSnackbarEvent(this.message);

  @override
  List<Object?> get props => [message];
}

// 🔹 Event to navigate to a contact's details screen
class NavigateToContactDetailsEvent extends ContactEvent {
  final ContactModel contact;

  NavigateToContactDetailsEvent(this.contact);

  @override
  List<Object?> get props => [contact];
}
