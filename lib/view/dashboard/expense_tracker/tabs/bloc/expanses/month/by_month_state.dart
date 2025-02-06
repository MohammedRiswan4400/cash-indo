part of 'by_month_bloc.dart';

sealed class ByMonthState extends Equatable {
  const ByMonthState();
  
  @override
  List<Object> get props => [];
}

final class ByMonthInitial extends ByMonthState {}
