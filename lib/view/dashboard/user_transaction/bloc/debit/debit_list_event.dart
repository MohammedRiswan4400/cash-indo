part of 'debit_list_bloc.dart';

abstract class DebitListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDebitList extends DebitListEvent {
  final String contactPhone;
  FetchDebitList(this.contactPhone);

  @override
  List<Object> get props => [contactPhone];
}
