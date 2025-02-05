part of 'by_date_bloc.dart';

abstract class ByDateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event to fetch income by date for the selected month
class FetchByDateEvent extends ByDateEvent {
  final String month;

  FetchByDateEvent(this.month);

  @override
  List<Object?> get props => [month];
}
