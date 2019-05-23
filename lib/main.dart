import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/screens/counter_home_screen.dart';
import 'package:flutter_meetuper/src/screens/meetup_detail_screen.dart';
import 'package:flutter_meetuper/src/screens/post_screen.dart';
import 'package:flutter_meetuper/src/state/app_state.dart';

void main() => runApp(AppStore(child: MeetuperApp()));

class MeetuperApp extends StatelessWidget {
  final String appTitle = 'Meetuper App';

  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: CounterHomeScreen(title: appTitle),
      home: PostScreen(),
      routes: {
        MeetupDetailScreen.route: (context) => MeetupDetailScreen()
      },
    );
  }
}



