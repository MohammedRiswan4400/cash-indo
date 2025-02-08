import 'package:bloc/bloc.dart';
import 'package:cash_indo/controller/db/expense_db/expense_db.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

// class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
//   CategoryBloc() : super(CategoryInitial()) {
//     on<CategoryEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }

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
