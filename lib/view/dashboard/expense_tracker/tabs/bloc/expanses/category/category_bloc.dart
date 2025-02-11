import 'package:cash_indo/controller/db/expense_db/expense_db.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class ExpenseByCategoryBloc
    extends Bloc<ExpenseByCategoryEvent, ExpenseByCategoryState> {
  ExpenseByCategoryBloc() : super(ExpenseByCategoryInitial()) {
    on<FetchExpenseByCategoryEvent>(_onFetchExpenseByCategoryExpenseByCategory);
  }

  // 🔹 Fetch category-wise expense and update state
  Future<void> _onFetchExpenseByCategoryExpenseByCategory(
      FetchExpenseByCategoryEvent event,
      Emitter<ExpenseByCategoryState> emit) async {
    emit(ExpenseByCategoryLoading());

    try {
      final categoryData =
          await ExpenseDb.getMonthlyExpenseByCategory(event.month);

      emit(ExpenseByCategoryLoaded(categoryData));
    } catch (e) {
      emit(ExpenseByCategoryError("Failed to fetch expense by category"));
    }
  }
}
