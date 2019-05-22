import 'package:flutter/material.dart';

void main() => runApp(MeetuperApp());


class MeetuperApp extends StatelessWidget {
  final String appTitle = 'Meetuper App';

  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CounterHomeScreen(title: appTitle)
    );
  }
}

class CounterHomeScreen extends StatelessWidget {
  final String _title;
  final int _counter = 0;

  CounterHomeScreen({String title}): _title = title;

  _increment() {
    print('I am clicking floating button!');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome in $_title, lets increment numbers!',
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 15.0)
            ),
            Text(
              'Counter: $_counter',
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 30.0)
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Increment',
        child: Icon(Icons.add)
      ),
      appBar: AppBar(title: Text(_title)),
    );
  }
}

