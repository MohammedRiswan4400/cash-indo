import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cash_indo/controller/db/income_db/income_db.dart';
import 'package:equatable/equatable.dart';

part 'by_category_event.dart';
part 'by_category_state.dart';

class IncomeByCategoryBloc
    extends Bloc<IncomeByCategoryEvent, IncomeByCategoryState> {
  IncomeByCategoryBloc() : super(IncomeByCategoryInitial()) {
    on<FetchIncomeByCategoryEvent>(_onFetchIncomeByCategoryIncomeByCategory);
  }

  // 🔹 Fetch category-wise income and update state
  Future<void> _onFetchIncomeByCategoryIncomeByCategory(
      FetchIncomeByCategoryEvent event,
      Emitter<IncomeByCategoryState> emit) async {
    emit(IncomeByCategoryLoading());

    try {
      final categoryData =
          await IncomeDb.getMonthlyIncomeByCategory(event.month);

      emit(IncomeByCategoryLoaded(categoryData));
    } catch (e) {
      emit(IncomeByCategoryError("Failed to fetch income by category"));
    }
  }
}
