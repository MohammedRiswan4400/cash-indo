part of 'credit_list_bloc.dart';

abstract class CreditListState extends Equatable {
  @override
  List<Object> get props => [];
}

class CreditListInitial extends CreditListState {}

class CreditListLoading extends CreditListState {}

class CreditListLoaded extends CreditListState {
  final List<CreditModel> credits;
  CreditListLoaded(this.credits);

  @override
  List<Object> get props => [credits];
}

class CreditListError extends CreditListState {
  final String message;
  CreditListError(this.message);

  @override
  List<Object> get props => [message];
}
