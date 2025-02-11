import 'package:cash_indo/controller/db/expense_db/expense_db.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weekly_expense_chart_event.dart';
part 'weekly_expense_chart_state.dart';

// class WeeklyExpenseWeeklyExpenseChartBloc
//     extends Bloc<WeeklyExpenseWeeklyExpenseChartEvent, WeeklyExpenseWeeklyExpenseChartState> {
//   WeeklyExpenseWeeklyExpenseChartBloc() : super(WeeklyExpenseWeeklyExpenseChartInitial()) {
//     on<FetchWeeklyExpenseWeeklyExpenseChartEvent>(_fetchExpenseData);
//   }

//   // Fetch expense data and update state
//   Future<void> _fetchExpenseData(FetchWeeklyExpenseWeeklyExpenseChartEvent event,
//       Emitter<WeeklyExpenseWeeklyExpenseChartState> emit) async {
//     emit(WeeklyExpenseWeeklyExpenseChartLoading());

//     try {
//       final data = await ExpenseDb.readWeaklyExpenseWeeklyExpenseChartData(event.month);
//       emit(WeeklyExpenseWeeklyExpenseChartLoaded(data));
//     } catch (e) {
//       emit(WeeklyExpenseWeeklyExpenseChartError("Failed to fetch expense data"));
//     }
//   }
// }

class WeeklyExpenseChartBloc
    extends Bloc<WeeklyExpenseChartEvent, WeeklyExpenseChartState> {
  WeeklyExpenseChartBloc() : super(WeeklyExpenseChartInitial()) {
    on<FetchWeeklyExpenseChartEvent>(_fetchExpenseData);
  }

  // ✅ Fetch grouped weekly expense data
  Future<void> _fetchExpenseData(FetchWeeklyExpenseChartEvent event,
      Emitter<WeeklyExpenseChartState> emit) async {
    emit(WeeklyExpenseChartLoading());

    try {
      final data = await ExpenseDb.readWeaklyExpenseChartData(event.month);
      emit(WeeklyExpenseChartLoaded(data)); // ✅ Pass fetched data to state
    } catch (e) {
      emit(WeeklyExpenseChartError("Failed to fetch expense data"));
    }
  }
}
