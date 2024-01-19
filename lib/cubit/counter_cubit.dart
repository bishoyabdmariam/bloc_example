import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

int counter = 0;

  void incrementCounter(){
    // make sure to emit the state before increment because there is anything will happen
    emit(CounterInitial());
    counter++;
    emit(CounterIncrement());
  }
}
