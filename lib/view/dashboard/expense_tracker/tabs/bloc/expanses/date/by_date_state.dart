part of 'by_date_bloc.dart';

abstract class ExpenseByDateState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state before fetching
class ExpenseByDateInitial extends ExpenseByDateState {}

// Loading state when data is being fetched
class ExpenseByDateLoading extends ExpenseByDateState {}

// Success state containing the grouped income data
class ExpenseByDateLoaded extends ExpenseByDateState {
  final List<List<ExpenseModel>> groupedData;

  ExpenseByDateLoaded(this.groupedData);

  @override
  List<Object?> get props => [groupedData];
}

// Error state if something goes wrong while fetching data
class ExpenseByDateError extends ExpenseByDateState {
  final String errorMessage;

  ExpenseByDateError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
