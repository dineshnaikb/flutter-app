import 'package:bloc/bloc.dart';

part 'switch_state.dart';

class SwitchCubit extends Cubit<SwitchState> {
  SwitchCubit() : super(SwitchState(counter: 0, items: []));

  void change(index) => emit(SwitchState(counter: index, items: state.items));
  void changeItems(List<String> items) =>
      emit(SwitchState(counter: state.counter, items: items));
}
