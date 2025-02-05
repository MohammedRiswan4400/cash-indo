import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cash_indo/controller/db/income_db/income_db.dart';
import 'package:equatable/equatable.dart';

part 'by_category_event.dart';
part 'by_category_state.dart';

class ByCategoryBloc extends Bloc<ByCategoryEvent, ByCategoryState> {
  ByCategoryBloc() : super(ByCategoryInitial()) {
    on<FetchByCategoryByCategoryEvent>(_onFetchByCategoryByCategory);
  }

  // 🔹 Fetch category-wise income and update state
  Future<void> _onFetchByCategoryByCategory(
      FetchByCategoryByCategoryEvent event,
      Emitter<ByCategoryState> emit) async {
    emit(ByCategoryLoading());

    try {
      final categoryData =
          await IncomeDb.getMonthlyIncomeByCategory(event.month);

      emit(ByCategoryByCategoryLoaded(categoryData));
    } catch (e) {
      emit(ByCategoryError("Failed to fetch income by category"));
    }
  }
}
