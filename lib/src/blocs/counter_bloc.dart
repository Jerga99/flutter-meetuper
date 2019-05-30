
import 'dart:async';
import 'package:flutter/material.dart';

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

class CounterBlocProvider extends StatefulWidget {
  final CounterBloc bloc;
  final Widget child;

  CounterBlocProvider({Key key, @required this.child})
    : bloc = CounterBloc(),
      super(key: key);

  _CounterBlocProviderState createState() => _CounterBlocProviderState();
}

class _CounterBlocProviderState extends State<CounterBlocProvider> {

  Widget build(BuildContext context) {
    return _CounterBlocProviderInherited(

    );
  }
}


class _CounterBlocProviderInherited extends InheritedWidget {
  final CounterBloc bloc;

  _CounterBlocProviderInherited({Widget child, Key key})
    : bloc = CounterBloc(),
      super(key: key, child: child);

  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  // static CounterBloc of(BuildContext context) {
  //   return (context.inheritFromWidgetOfExactType(CounterBlocProvider)
  //    as CounterBlocProvider).bloc;
  // }
}



