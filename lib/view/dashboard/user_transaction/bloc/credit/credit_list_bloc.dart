import 'package:cash_indo/controller/db/credit_db/credit_db.dart';
import 'package:cash_indo/model/credit_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'credit_list_event.dart';
part 'credit_list_state.dart';

class CreditListBloc extends Bloc<CreditListEvent, CreditListState> {
  CreditListBloc() : super(CreditListInitial()) {
    on<FetchCreditList>(_onFetchCreditList);
  }

  Future<void> _onFetchCreditList(
      FetchCreditList event, Emitter<CreditListState> emit) async {
    emit(CreditListLoading());

    try {
      final List<CreditModel> credits =
          await CreditDb.readCredit(contactPhone: event.contactPhone);

      emit(CreditListLoaded(credits));
    } catch (e) {
      emit(CreditListError('Failed to fetch credit list: $e'));
    }
  }
}
