import 'package:cash_indo/controller/db/expense_db/expense_db.dart';
import 'package:cash_indo/model/expense_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'by_date_event.dart';
part 'by_date_state.dart';

class ExpenseByDateBloc extends Bloc<ExpenseByDateEvent, ExpenseByDateState> {
  ExpenseByDateBloc() : super(ExpenseByDateInitial()) {
    on<FetchExpenseByDateEvent>(_onFetchExpenseByDateExpenseByDate);
  }

  Future<void> _onFetchExpenseByDateExpenseByDate(
      FetchExpenseByDateEvent event, Emitter<ExpenseByDateState> emit) async {
    emit(ExpenseByDateLoading());

    try {
      final categoryData = await ExpenseDb.readExpense(event.month);

      emit(ExpenseByDateLoaded(categoryData));
    } catch (e) {
      emit(ExpenseByDateError("Failed to fetch income by category"));
    }
  }
}
