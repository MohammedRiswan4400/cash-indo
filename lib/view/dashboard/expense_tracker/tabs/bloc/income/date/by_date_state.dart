part of 'by_date_bloc.dart';

abstract class IncomeByDateState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state before fetching
class IncomeByDateInitial extends IncomeByDateState {}

// Loading state when data is being fetched
class IncomeByDateLoading extends IncomeByDateState {}

// Success state containing the grouped income data
class IncomeByDateLoaded extends IncomeByDateState {
  final List<List<IncomeModel>> groupedData;

  IncomeByDateLoaded(this.groupedData);

  @override
  List<Object?> get props => [groupedData];
}

// Error state if something goes wrong while fetching data
class IncomeByDateError extends IncomeByDateState {
  final String errorMessage;

  IncomeByDateError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
