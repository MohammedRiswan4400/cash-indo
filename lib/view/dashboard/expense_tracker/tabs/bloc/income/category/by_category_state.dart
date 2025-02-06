part of 'by_category_bloc.dart';

abstract class IncomeByCategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

// 🔹 Initial state
class IncomeByCategoryInitial extends IncomeByCategoryState {}

// 🔹 Loading state
class IncomeByCategoryLoading extends IncomeByCategoryState {}

// 🔹 Success state with category-wise totals
class IncomeByCategoryLoaded extends IncomeByCategoryState {
  final List<Map<String, dynamic>> categoryIncomeByCategory;

  IncomeByCategoryLoaded(this.categoryIncomeByCategory);

  @override
  List<Object?> get props => [categoryIncomeByCategory];
}

// 🔹 Error state
class IncomeByCategoryError extends IncomeByCategoryState {
  final String errorMessage;

  IncomeByCategoryError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
