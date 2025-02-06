import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'by_month_event.dart';
part 'by_month_state.dart';

class ByMonthBloc extends Bloc<ByMonthEvent, ByMonthState> {
  ByMonthBloc() : super(ByMonthInitial()) {
    on<ByMonthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
