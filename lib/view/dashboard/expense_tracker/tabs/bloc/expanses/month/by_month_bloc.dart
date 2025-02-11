import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'by_month_event.dart';
part 'by_month_state.dart';

class ByMonthBloc extends Bloc<ByMonthEvent, ByMonthState> {
  ByMonthBloc() : super(ByMonthInitial()) {
    on<ByMonthEvent>((event, emit) {});
  }
}
