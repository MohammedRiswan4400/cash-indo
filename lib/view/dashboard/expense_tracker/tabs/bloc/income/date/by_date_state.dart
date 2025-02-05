part of 'by_date_bloc.dart';

abstract class ByDateState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state before fetching
class ByDateInitial extends ByDateState {}

// Loading state when data is being fetched
class ByDateLoading extends ByDateState {}

// Success state containing the grouped income data
class ByDateLoaded extends ByDateState {
  final List<List<IncomeModel>> groupedData;

  ByDateLoaded(this.groupedData);

  @override
  List<Object?> get props => [groupedData];
}

// Error state if something goes wrong while fetching data
class ByDateError extends ByDateState {
  final String errorMessage;

  ByDateError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
