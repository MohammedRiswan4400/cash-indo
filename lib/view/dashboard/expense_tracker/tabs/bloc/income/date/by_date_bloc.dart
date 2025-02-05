import 'package:bloc/bloc.dart';
import 'package:cash_indo/controller/db/income_db/income_db.dart';
import 'package:cash_indo/model/income_model.dart';
import 'package:equatable/equatable.dart';

part 'by_date_event.dart';
part 'by_date_state.dart';

// class ByDateBloc extends Bloc<ByDateEvent, ByDateState> {
//   ByDateBloc() : super(ByDateInitial());

//   // @override
//   Stream<ByDateState> mapEventToState(ByDateEvent event)  {
//        on<FetchByDateEvent>(_onFetchByDate);
//     if (event is FetchByDateEvent) {
//       yield* _onFetchByDate(event);  // Use yield* to handle async operations
//     }
//   }

//   // 🔹 Fetch income data by date for the selected month
//   Future<void> _onFetchByDate(FetchByDateEvent event)  {
//     yield ByDateLoading();  // Emit loading state while fetching data

//     try {
//       // Fetch income data for the selected month asynchronously
//       final groupedData = await UserDb.readIncome(event.month);

//       // Emit the success state with the grouped data once fetched
//       yield ByDateLoaded(groupedData);
//     } catch (e) {
//       // Emit the error state if fetching data fails
//       yield ByDateError("Failed to fetch income by date: $e");
//     }
//   }
// }

class ByDateBloc extends Bloc<ByDateEvent, ByDateState> {
  ByDateBloc() : super(ByDateInitial()) {
    on<FetchByDateEvent>(_onFetchByDateByDate);
  }

  // 🔹 Fetch category-wise income and update state
  Future<void> _onFetchByDateByDate(
      FetchByDateEvent event, Emitter<ByDateState> emit) async {
    emit(ByDateLoading());

    try {
      final categoryData = await IncomeDb.readIncome(event.month);

      emit(ByDateLoaded(categoryData));
    } catch (e) {
      emit(ByDateError("Failed to fetch income by category"));
    }
  }
}
