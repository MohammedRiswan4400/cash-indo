part of 'category_bloc.dart';

abstract class ExpenseByCategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

// 🔹 Initial state
class ExpenseByCategoryInitial extends ExpenseByCategoryState {}

// 🔹 Loading state
class ExpenseByCategoryLoading extends ExpenseByCategoryState {}

// 🔹 Success state with category-wise totals
class ExpenseByCategoryLoaded extends ExpenseByCategoryState {
  final List<Map<String, dynamic>> categoryExpenseByCategory;

  ExpenseByCategoryLoaded(this.categoryExpenseByCategory);

  @override
  List<Object?> get props => [categoryExpenseByCategory];
}

// 🔹 Error state
class ExpenseByCategoryError extends ExpenseByCategoryState {
  final String errorMessage;

  ExpenseByCategoryError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
