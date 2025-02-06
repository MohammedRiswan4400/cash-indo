part of 'by_date_bloc.dart';

abstract class ExpenseByDateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event to fetch income by date for the selected month
class FetchExpenseByDateEvent extends ExpenseByDateEvent {
  final String month;

  FetchExpenseByDateEvent(this.month);

  @override
  List<Object?> get props => [month];
}
