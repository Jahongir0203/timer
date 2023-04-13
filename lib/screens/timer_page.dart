import 'package:flutter/material.dart';
import 'package:timer/logic/timer_bloc.dart';
import 'package:timer/ticker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(ticker: Ticker()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Timer"),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.shade50,
                    Colors.blue.shade500,
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100.0),
                  child: Center(child: TimerText()),
                ),
                Actions(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesSt = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsSt = (duration % 60).floor().toString().padLeft(2, '0');

    return Text(minutesSt + ":" + secondsSt,
        style: Theme.of(context).textTheme.headlineMedium);
  }
}

class Actions extends StatelessWidget {
  const Actions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (state is TimerInitial) ...[
              FloatingActionButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: () {
                    context
                        .read<TimerBloc>()
                        .add(TimerStarted(duration: state.duration));
                  }),
            ],
            if (state is TimerRunInProgress) ...[
              FloatingActionButton(
                  child: Icon(Icons.pause),
                  onPressed: () {
                    context.read<TimerBloc>().add(TimerPaused());
                  }),
              FloatingActionButton(
                  child: Icon(Icons.replay),
                  onPressed: () {
                    context.read<TimerBloc>().add(TimerReset());
                  })
            ],
            if (state is TimerRunPause) ...[
              FloatingActionButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: () {
                    context.read<TimerBloc>().add(TimerResumed());
                  }),
              FloatingActionButton(
                  child: Icon(Icons.replay),
                  onPressed: () {
                    context.read<TimerBloc>().add(TimerReset());
                  })
            ],
            if (state is TimerRunComplate) ...[
              FloatingActionButton(
                  child: Icon(Icons.replay),
                  onPressed: () {
                    context.read<TimerBloc>().add(TimerReset());
                  })
            ]
          ],
        );
      },
    );
  }
}
