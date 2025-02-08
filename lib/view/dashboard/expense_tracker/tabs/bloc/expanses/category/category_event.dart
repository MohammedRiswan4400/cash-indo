part of 'category_bloc.dart';

abstract class ExpenseByCategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// 🔹 Event to fetch category-wise expense for a month
class FetchExpenseByCategoryEvent extends ExpenseByCategoryEvent {
  final String month;

  FetchExpenseByCategoryEvent(this.month);

  @override
  List<Object?> get props => [month];
}
