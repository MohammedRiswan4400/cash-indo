part of 'income_monthly_total_bloc.dart';

abstract class IncomeMonthlyTotalEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event to fetch income for a selected month
class FetchMonthlyIncomeTotal extends IncomeMonthlyTotalEvent {
  final String month;

  FetchMonthlyIncomeTotal(this.month);

  @override
  List<Object?> get props => [month];
}
