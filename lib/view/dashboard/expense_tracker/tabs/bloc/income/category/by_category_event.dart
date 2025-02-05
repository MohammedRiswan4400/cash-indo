part of 'by_category_bloc.dart';

abstract class ByCategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// 🔹 Event to fetch category-wise income for a month
class FetchByCategoryByCategoryEvent extends ByCategoryEvent {
  final String month;

  FetchByCategoryByCategoryEvent(this.month);

  @override
  List<Object?> get props => [month];
}
