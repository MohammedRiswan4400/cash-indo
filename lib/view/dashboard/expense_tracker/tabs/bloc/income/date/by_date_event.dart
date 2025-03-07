part of 'by_date_bloc.dart';

abstract class IncomeByDateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event to fetch income by date for the selected month
class FetchIncomeByDateEvent extends IncomeByDateEvent {
  final String month;

  FetchIncomeByDateEvent(this.month);

  @override
  List<Object?> get props => [month];
}
