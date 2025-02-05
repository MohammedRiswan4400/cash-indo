import 'dart:async';

import 'package:cash_indo/controller/db/contacts_db/contact_db.dart';
import 'package:cash_indo/model/contact_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  StreamSubscription<List<ContactModel>>? _contactStreamSubscription;

  ContactBloc() : super(ContactInitial()) {
    on<FetchContactsEvent>(_onFetchContacts);
    on<ContactUpdatedEvent>(_onContactUpdated);
    // on<TriggerSnackbarEvent>(_onTriggerSnackbar);
    // on<NavigateToContactDetailsEvent>(_onNavigateToContactDetails);
  }

  // 🔹 Fetch contacts from Supabase and listen to the stream
  Future<void> _onFetchContacts(
      FetchContactsEvent event, Emitter<ContactState> emit) async {
    emit(ContactLoading());

    try {
      _contactStreamSubscription?.cancel();

      _contactStreamSubscription = ContactDb.readContacts().listen(
        (contacts) {
          add(ContactUpdatedEvent(contacts)); // Emit update event
        },
        onError: (error) {
          emit(ContactError("Failed to fetch contacts."));
        },
      );
    } catch (e) {
      emit(ContactError("Failed to fetch contacts."));
    }
  }

  // 🔹 Update contacts when new data arrives
  void _onContactUpdated(
      ContactUpdatedEvent event, Emitter<ContactState> emit) {
    emit(ContactLoaded(event.contacts));
  }

  // // 🔹 Show a snackbar action
  // void _onTriggerSnackbar(
  //     TriggerSnackbarEvent event, Emitter<ContactState> emit) {
  //   emit(ShowContactSnackbar(event.message));
  // }

  // // 🔹 Navigate to contact details
  // void _onNavigateToContactDetails(
  //     NavigateToContactDetailsEvent event, Emitter<ContactState> emit) {
  //   emit(NavigateToContactDetails(event.contact));
  // }

  @override
  Future<void> close() {
    _contactStreamSubscription?.cancel();
    return super.close();
  }
}
