part of 'by_category_bloc.dart';

abstract class ByCategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

// 🔹 Initial state
class ByCategoryInitial extends ByCategoryState {}

// 🔹 Loading state
class ByCategoryLoading extends ByCategoryState {}

// 🔹 Success state with category-wise totals
class ByCategoryByCategoryLoaded extends ByCategoryState {
  final List<Map<String, dynamic>> categoryByCategory;

  ByCategoryByCategoryLoaded(this.categoryByCategory);

  @override
  List<Object?> get props => [categoryByCategory];
}

// 🔹 Error state
class ByCategoryError extends ByCategoryState {
  final String errorMessage;

  ByCategoryError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
