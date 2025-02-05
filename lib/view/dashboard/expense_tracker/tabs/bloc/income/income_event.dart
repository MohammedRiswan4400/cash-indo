part of 'income_bloc.dart';

abstract class IncomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event to fetch income for a selected month
class FetchMonthlyIncome extends IncomeEvent {
  final String month;

  FetchMonthlyIncome(this.month);

  @override
  List<Object?> get props => [month];
}
