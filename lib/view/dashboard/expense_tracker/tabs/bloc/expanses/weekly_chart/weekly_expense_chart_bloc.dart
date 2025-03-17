import 'package:cash_indo/controller/db/expense_db/expense_db.dart';
import 'package:cash_indo/widget/drop_down_widgets.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weekly_expense_chart_event.dart';
part 'weekly_expense_chart_state.dart';

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
      final data = await ExpenseDb.readWeeklyExpenseChartData(
          selectedMonthNotifier.value);
      emit(WeeklyExpenseChartLoaded(data)); // ✅ Pass fetched data to state
    } catch (e) {
      emit(WeeklyExpenseChartError("Failed to fetch expense data"));
    }
  }
}
