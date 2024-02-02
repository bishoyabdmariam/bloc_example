
part of 'decremental_counter_cubit.dart';


abstract class DecrementalCounterState extends Equatable {
  const DecrementalCounterState();

  @override
  List<Object> get props => [];
}

class DecrementalCounterInitial extends DecrementalCounterState {}

class DecrementalCounterLoading extends DecrementalCounterState {}
