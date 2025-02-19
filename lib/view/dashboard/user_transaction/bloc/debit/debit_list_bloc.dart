import 'package:cash_indo/controller/db/debit_db/debit_db.dart';
import 'package:cash_indo/model/debit_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'debit_list_event.dart';
part 'debit_list_state.dart';

class DebitListBloc extends Bloc<DebitListEvent, DebitListState> {
  DebitListBloc() : super(DebitListInitial()) {
    on<FetchDebitList>(_onFetchDebitList);
  }

  Future<void> _onFetchDebitList(
      FetchDebitList event, Emitter<DebitListState> emit) async {
    emit(DebitListLoading());

    try {
      final List<DebitModel> debits =
          await DebitDb.readDebit(contactPhone: event.contactPhone);

      emit(DebitListLoaded(debits));
    } catch (e) {
      emit(DebitListError('Failed to fetch debit list: $e'));
    }
  }
}
