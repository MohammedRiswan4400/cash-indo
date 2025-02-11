import 'package:cash_indo/widget/expansion_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpansionCubit extends Cubit<bool> {
  ExpansionCubit() : super(false);

  void toggle() {
    emit(!state);
    isListExpanded.value = state;
  }
}
