

import 'dart:async';

class CounterBloc {
  final StreamController<int> _streamController = StreamController<int>.broadcast();
  final StreamController<int> _counterController = StreamController<int>.broadcast();

  Stream<int> get counterStream => _counterController.stream;
  StreamSink<int> get counterSink => _counterController.sink;


  int _counter = 0;

  CounterBloc() {
    _streamController.stream
      .listen(_handleIncrement);
  }

  _handleIncrement(int number) {
    _counter += number;
    counterSink.add(_counter);
  }

  increment(int incrementer) {
    _streamController.sink.add(incrementer);
  }

  dispose() {
    _streamController.close();
    _counterController.close();
  }
}

final CounterBloc counterBloc = CounterBloc();



