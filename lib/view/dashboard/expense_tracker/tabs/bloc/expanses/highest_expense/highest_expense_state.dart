part of 'highest_expense_bloc.dart';

abstract class HighestExpenseState extends Equatable {
  @override
  List<Object?> get props => [];
}

// ✅ Initial state
class HighestExpenseInitial extends HighestExpenseState {}

// ✅ Loading state
class HighestExpenseLoading extends HighestExpenseState {}

// ✅ Highest Weekly Expense Loaded
class HighestWeeklyExpensesLoaded extends HighestExpenseState {
  final String highestDay;
  final double highestAmount;

  HighestWeeklyExpensesLoaded(this.highestDay, this.highestAmount);

  @override
  List<Object?> get props => [highestDay, highestAmount];
}

// ✅ Error state
class HighestExpenseError extends HighestExpenseState {
  final String errorMessage;
  HighestExpenseError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
