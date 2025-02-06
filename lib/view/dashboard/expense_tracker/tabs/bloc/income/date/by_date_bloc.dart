import 'package:cash_indo/controller/db/income_db/income_db.dart';
import 'package:cash_indo/model/income_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'by_date_event.dart';
part 'by_date_state.dart';

class IncomeByDateBloc extends Bloc<IncomeByDateEvent, IncomeByDateState> {
  IncomeByDateBloc() : super(IncomeByDateInitial()) {
    on<FetchIncomeByDateEvent>(_onFetchIncomeByDateIncomeByDate);
  }

  // 🔹 Fetch category-wise income and update state
  Future<void> _onFetchIncomeByDateIncomeByDate(
      FetchIncomeByDateEvent event, Emitter<IncomeByDateState> emit) async {
    emit(IncomeByDateLoading());

    try {
      final categoryData = await IncomeDb.readIncome(event.month);

      emit(IncomeByDateLoaded(categoryData));
    } catch (e) {
      emit(IncomeByDateError("Failed to fetch income by category"));
    }
  }
}
