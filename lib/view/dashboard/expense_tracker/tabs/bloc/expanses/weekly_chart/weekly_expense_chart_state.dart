part of 'weekly_expense_chart_bloc.dart';

abstract class WeeklyExpenseChartState extends Equatable {
  @override
  List<Object?> get props => [];
}

// ✅ Initial state
class WeeklyExpenseChartInitial extends WeeklyExpenseChartState {}

// ✅ Loading state
class WeeklyExpenseChartLoading extends WeeklyExpenseChartState {}

// ✅ Weekly Chart Data Loaded
class WeeklyExpenseChartLoaded extends WeeklyExpenseChartState {
  final List<BarChartGroupData> chartData;
  WeeklyExpenseChartLoaded(this.chartData);

  @override
  List<Object?> get props => [chartData];
}

// ✅ Weekly Total Expense Loaded
class WeeklyTotalLoaded extends WeeklyExpenseChartState {
  final double weeklyTotal;
  WeeklyTotalLoaded(this.weeklyTotal);

  @override
  List<Object?> get props => [weeklyTotal];
}

// // ✅ Highest Weekly Expense Loaded
// class HighestWeeklyExpenseLoaded extends WeeklyExpenseChartState {
//   final String highestDay;
//   final double highestAmount;

//   HighestWeeklyExpenseLoaded(this.highestDay, this.highestAmount);

//   @override
//   List<Object?> get props => [highestDay, highestAmount];
// }

// ✅ Error state
class WeeklyExpenseChartError extends WeeklyExpenseChartState {
  final String errorMessage;
  WeeklyExpenseChartError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
