import 'package:flutter/material.dart';



class BlocProvider<T> extends StatefulWidget {

  final T bloc;
  final Widget child;

  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc
  }): super(key: key);

  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  //  static CounterBloc of(BuildContext context) {
  //   _CounterBlocProviderInherited provider =
  //     (context.ancestorInheritedElementForWidgetOfExactType(_CounterBlocProviderInherited)?.widget
  //    as _CounterBlocProviderInherited);
}

class _BlocProviderState<T> extends State<BlocProvider<T>> {

  Widget build(BuildContext context) {
    return null;
  }
}
