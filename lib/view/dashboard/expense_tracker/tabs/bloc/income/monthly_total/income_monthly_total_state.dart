part of 'income_monthly_total_bloc.dart';

abstract class IncomeMonthlyTotalState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial State
class IncomeMonthlyTotalInitial extends IncomeMonthlyTotalState {}

// Loading State
class IncomeMonthlyTotalLoading extends IncomeMonthlyTotalState {}

// Success State
class IncomeMonthlyTotalLoaded extends IncomeMonthlyTotalState {
  final double totalMonthlyIncome;

  IncomeMonthlyTotalLoaded(this.totalMonthlyIncome);

  @override
  List<Object?> get props => [totalMonthlyIncome];
}

// Error State
class IncomeMonthlyTotalError extends IncomeMonthlyTotalState {
  final String message;

  IncomeMonthlyTotalError(this.message);

  @override
  List<Object?> get props => [message];
}
