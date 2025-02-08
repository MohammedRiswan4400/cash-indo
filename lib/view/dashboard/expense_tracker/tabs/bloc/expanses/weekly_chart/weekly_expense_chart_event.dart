part of 'weekly_expense_chart_bloc.dart';

// sealed class WeeklyExpenseWeeklyExpenseChartEvent extends Equatable {
//   const WeeklyExpenseWeeklyExpenseChartEvent();

//   @override
//   List<Object> get props => [];
// }

abstract class WeeklyExpenseChartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// ✅ Fetch weekly bar chart data
class FetchWeeklyExpenseChartEvent extends WeeklyExpenseChartEvent {
  final String month;
  FetchWeeklyExpenseChartEvent(this.month);

  @override
  List<Object?> get props => [month];
}

// ✅ Fetch total weekly expense
class FetchWeeklyTotalEvent extends WeeklyExpenseChartEvent {}

// // ✅ Fetch the highest spending day of the week
// class FetchHighestWeeklyExpenseEvent extends WeeklyExpenseChartEvent {}
