import 'package:cash_indo/controller/db/expense_db/expense_db.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'highest_expense_event.dart';
part 'highest_expense_state.dart';

class HighestExpenseBloc
    extends Bloc<HighestExpenseEvent, HighestExpenseState> {
  HighestExpenseBloc() : super(HighestExpenseInitial()) {
    on<FetchHighestWeeklyExpenseEvent>(
        _fetchHighestExpense); // ✅ Correct event handler
  }

  // ✅ Fetch highest weekly expense
  Future<void> _fetchHighestExpense(FetchHighestWeeklyExpenseEvent event,
      Emitter<HighestExpenseState> emit) async {
    emit(HighestExpenseLoading());

    try {
      final result = await ExpenseDb.getHighestWeeklyExpense("February");

      if (result["day"] == null || result["amount"] == null) {
        emit(HighestExpenseError("No highest expense found."));
      } else {
        emit(HighestWeeklyExpensesLoaded(result["day"], result["amount"]));
      }
    } catch (e) {
      emit(HighestExpenseError("Failed to fetch highest weekly expense"));
    }
  }
}
