import 'package:flutter/material.dart';




class AppStore extends StatefulWidget {
  final Widget child;

  AppStore({@required this.child});

  _AppStoreState createState() => _AppStoreState();

  static _AppStoreState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedAppState)
      as _InheritedAppState).data;
  }
}

class _AppStoreState extends State<AppStore> {
  String testingData = 'Testing Data (:';
  String testingData2 = 'Testing Data 2 (:';
  String testingData3 = 'Testing Data 3 (:';

  Widget build(BuildContext context) {
    return _InheritedAppState(
      child: widget.child,
      data: this
    );
  }
}

class _InheritedAppState extends InheritedWidget {
  final _AppStoreState data;

  _InheritedAppState({@required Widget child,
                      @required this.data}) : super(child: child);

  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
