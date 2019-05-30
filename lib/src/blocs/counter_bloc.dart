

import 'dart:async';

class CounterBloc {
  final StreamController<int> _streamController = StreamController<int>.broadcast();
  final StreamController<int> counterController = StreamController<int>.broadcast();
  int _counter = 0;

  CounterBloc() {
    _streamController.stream
      .listen(_handleIncrement);
  }

  _handleIncrement(int number) {
    _counter += number;
    counterController.sink.add(_counter);
  }

  increment(int incrementer) {
    _streamController.sink.add(incrementer);
  }

  dispose() {
    _streamController.close();
    counterController.close();
  }
}

final CounterBloc counterBloc = CounterBloc();



