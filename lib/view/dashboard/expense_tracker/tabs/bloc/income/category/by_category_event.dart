part of 'by_category_bloc.dart';

abstract class IncomeByCategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// 🔹 Event to fetch category-wise income for a month
class FetchIncomeByCategoryEvent extends IncomeByCategoryEvent {
  final String month;

  FetchIncomeByCategoryEvent(this.month);

  @override
  List<Object?> get props => [month];
}
