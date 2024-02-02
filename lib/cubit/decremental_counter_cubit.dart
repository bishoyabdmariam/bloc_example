import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'decremental_counter_state.dart';

class DecrementalCounterCubit extends Cubit<DecrementalCounterState> {
  DecrementalCounterCubit() : super(DecrementalCounterInitial());

  void decrement(int counter) {
    emit(DecrementalCounterLoading());
    counter--;
    emit(DecrementalCounterInitial());
  }
}
