import 'package:flutter/material.dart';

void main() => runApp(MeetuperApp());


class MeetuperApp extends StatelessWidget {
  final String appTitle = 'Meetuper App';

  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: Center(
          child: Text(
            'Welcome in $appTitle!',
            textDirection: TextDirection.ltr
          ),
        ),
        appBar: AppBar(title: Text(appTitle)),
      )
    );
  }
}
