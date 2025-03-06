import 'dart:async';
import 'package:calculator/timer/neu_digital_clock.dart';
import 'package:calculator/timer/neu_hamburger_button.dart';
import 'package:calculator/timer/neu_progress_pie_bar.dart';
import 'package:calculator/timer/neu_reset_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final timeService = TimerService();
    return ChangeNotifierProvider<TimerService>(
      create: (_) => timeService,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).viewPadding.top + 20),
                TimerTitle(),
                SizedBox(height: 20),
                NeuDigitalClock(),
                SizedBox(height: 10),
                NeuProgressPieBar(),
                SizedBox(height: 15),
                NeuResetButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimerTitle extends StatelessWidget {
  const TimerTitle({super.key});


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          'Timer',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Spacer(),
        NeuHamburgerButton()
      ],
    );
  }
}

class TimerService extends ChangeNotifier {
  late Stopwatch _watch;
  Timer? _timer;

  Duration get currentDuration => _currentDuration;
  Duration _currentDuration = Duration.zero;

  bool get isRunning => _timer != null;

  TimerService() {
    _watch = Stopwatch();
  }

  void _onTick(Timer timer) {
    _currentDuration = _watch.elapsed;

    // notify all listening widgets
    notifyListeners();
  }

  void start() {
    if (_timer != null) return;

    _timer = Timer.periodic(Duration(seconds: 1), _onTick);
    _watch.start();

    notifyListeners();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _watch.stop();
    _currentDuration = _watch.elapsed;

    notifyListeners();
  }

  void reset() {
    stop();
    _watch.reset();
    _currentDuration = Duration.zero;

    notifyListeners();
  }
  // source: https://stackoverflow.com/questions/53228993/how-to-implement-persistent-stopwatch-in-flutter
}
