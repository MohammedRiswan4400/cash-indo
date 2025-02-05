part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  @override
  List<Object?> get props => [];
}

// ✅ Action State (Used for one-time UI actions like navigation/snackbar)
abstract class ContactActionState extends ContactState {}

// ✅ Initial state
class ContactInitial extends ContactState {}

// ✅ Loading state
class ContactLoading extends ContactState {}

// ✅ Loaded state (Contains a list of contacts)
class ContactLoaded extends ContactState {
  final List<ContactModel> contacts;

  ContactLoaded(this.contacts);

  @override
  List<Object?> get props => [contacts];
}

// ✅ Error state (Displays an error message)
class ContactError extends ContactState {
  final String errorMessage;

  ContactError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

// ✅ Example of Action States (For navigation, showing messages, etc.)
class ShowContactSnackbar extends ContactActionState {
  final String message;

  ShowContactSnackbar(this.message);

  @override
  List<Object?> get props => [message];
}

class NavigateToContactDetails extends ContactActionState {
  final ContactModel contact;

  NavigateToContactDetails(this.contact);

  @override
  List<Object?> get props => [contact];
}
