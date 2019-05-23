import 'package:flutter/material.dart';




class AppStore extends StatefulWidget {
  final Widget child;

  AppStore({@required this.child});

  _AppStoreState createState() => _AppStoreState();
}

class _AppStoreState extends State<AppStore> {

  Widget build(BuildContext context) {
    return _InheritedAppState(
      child: widget.child
    );
  }
}

class _InheritedAppState extends InheritedWidget {

  _InheritedAppState({@required Widget child}) : super(child: child);

  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
