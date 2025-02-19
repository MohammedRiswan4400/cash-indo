part of 'credit_list_bloc.dart';

abstract class CreditListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCreditList extends CreditListEvent {
  final String contactPhone;
  FetchCreditList(this.contactPhone);

  @override
  List<Object> get props => [contactPhone];
}
