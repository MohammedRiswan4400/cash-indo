part of 'income_bloc.dart';

abstract class IncomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial State
class IncomeInitial extends IncomeState {}

// Loading State
class IncomeLoading extends IncomeState {}

// Success State
class IncomeLoaded extends IncomeState {
  final double totalIncome;

  IncomeLoaded(this.totalIncome);

  @override
  List<Object?> get props => [totalIncome];
}

// Error State
class IncomeError extends IncomeState {
  final String message;

  IncomeError(this.message);

  @override
  List<Object?> get props => [message];
}
