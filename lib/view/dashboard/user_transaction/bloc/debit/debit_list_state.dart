part of 'debit_list_bloc.dart';

abstract class DebitListState extends Equatable {
  @override
  List<Object> get props => [];
}

class DebitListInitial extends DebitListState {}

class DebitListLoading extends DebitListState {}

class DebitListLoaded extends DebitListState {
  final List<DebitModel> debits;
  DebitListLoaded(this.debits);

  @override
  List<Object> get props => [debits];
}

class DebitListError extends DebitListState {
  final String message;
  DebitListError(this.message);

  @override
  List<Object> get props => [message];
}
