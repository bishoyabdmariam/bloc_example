import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ticker.dart';

part 'timer_event.dart';

part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _duration = 20;
  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<_TimerTicked>(_onTicked);
    on<TimerReset>(_onReset);
    on<TimerAdd>(_onAdd);
    on<TimerEnd>(_onEnd);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(_TimerTicked(duration: duration)));
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }

  void _onReset(TimerReset reset, Emitter<TimerState> emit) {
    emit(TimerInitial(state.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: _duration)
        .listen((duration) => add(_TimerTicked(duration: duration)));
    emit(TimerRunInProgress(state.duration));
  }

  void _onEnd(TimerEnd end, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();/*
    _tickerSubscription = _ticker
        .tick(ticks: _duration)
        .listen((duration) => add(_TimerTicked(duration: duration)));*/
    emit(TimerInitial(_duration));
  }

  void _onAdd(TimerAdd addTime, Emitter<TimerState> emit) {
    emit(TimerRunPause(state.duration));
    _tickerSubscription?.pause();
    _tickerSubscription = _ticker
        .tick(ticks: state.duration + 30)
        .listen((duration) => add(_TimerTicked(duration: duration)));
    _tickerSubscription?.resume();
    emit(TimerRunInProgress(state.duration));
  }

  void _onResumed(TimerResumed resume, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  void _onTicked(_TimerTicked event, Emitter<TimerState> emit) {
    emit(
      event.duration > 0
          ? TimerRunInProgress(event.duration)
          : const TimerRunComplete(),
    );
  }
}
