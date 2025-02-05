import 'package:cash_indo/controller/db/income_db/income_db.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'income_monthly_total_event.dart';
part 'income_monthly_total_state.dart';

class IncomeMonthlyTotalBloc
    extends Bloc<IncomeMonthlyTotalEvent, IncomeMonthlyTotalState> {
  IncomeMonthlyTotalBloc() : super(IncomeMonthlyTotalInitial()) {
    on<FetchMonthlyIncomeTotal>((event, emit) async {
      emit(IncomeMonthlyTotalLoading()); // Show loading state

      try {
        double totalIncomeMonthlyTotal =
            await IncomeDb.getMonthlyIncomeTotal(event.month);
        emit(IncomeMonthlyTotalLoaded(totalIncomeMonthlyTotal));
      } catch (e) {
        emit(IncomeMonthlyTotalError("Failed to load income data"));
      }
    });
  }
}
