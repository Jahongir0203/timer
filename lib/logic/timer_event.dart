part of 'timer_bloc.dart';

abstract class TimerEvent {
  const TimerEvent();
}

// TimerStarted — informs the TimerBloc that the timer should be started.
// TimerPaused — informs the TimerBloc that the timer should be paused.
// TimerResumed — informs the TimerBloc that the timer should be resumed.
// TimerReset — informs the TimerBloc that the timer should be reset to the original state.
// _TimerTicked — informs the TimerBloc that a tick has occurred and that it needs to update its state accordingly.
class TimerStarted extends TimerEvent {
  final int duration;

  const TimerStarted({required this.duration});
}

class TimerPaused extends TimerEvent {
  const TimerPaused();
}

class TimerResumed extends TimerEvent {
  const TimerResumed();
}

class TimerReset extends TimerEvent {
  const TimerReset();
}

class _TimerTicked extends TimerEvent {
  final int duration;

  const _TimerTicked({required this.duration});
}
