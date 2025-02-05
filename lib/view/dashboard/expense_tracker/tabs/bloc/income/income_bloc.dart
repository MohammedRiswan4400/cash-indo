import 'package:cash_indo/controller/db/income_db/income_db.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  IncomeBloc() : super(IncomeInitial()) {
    on<FetchMonthlyIncome>((event, emit) async {
      emit(IncomeLoading()); // Show loading state

      try {
        double totalIncome = await IncomeDb.getMonthlyIncomeTotal(event.month);
        emit(IncomeLoaded(totalIncome));
      } catch (e) {
        emit(IncomeError("Failed to load income data"));
      }
    });
  }
}
