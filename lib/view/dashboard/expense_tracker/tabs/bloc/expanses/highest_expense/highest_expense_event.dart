part of 'highest_expense_bloc.dart';

abstract class HighestExpenseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// ✅ Event to fetch the highest weekly expense
class FetchHighestWeeklyExpenseEvent extends HighestExpenseEvent {}
