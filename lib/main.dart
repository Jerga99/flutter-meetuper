import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/models/arguments.dart';
import 'package:flutter_meetuper/src/screens/login_screen.dart';
import 'package:flutter_meetuper/src/screens/meetup_detail_screen.dart';
import 'package:flutter_meetuper/src/screens/meetup_home_screen.dart';
import 'package:flutter_meetuper/src/screens/register_screen.dart';

void main() => runApp(MeetuperApp());

class MeetuperApp extends StatelessWidget {
  final String appTitle = 'Meetuper App';

  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: CounterHomeScreen(title: appTitle),
      home: LoginScreen(),
      routes: {
        MeetupHomeScreen.route: (context) => MeetupHomeScreen(),
        RegisterScreen.route: (context) => RegisterScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == MeetupDetailScreen.route) {
          final MeetupDetailArguments arguments = settings.arguments;

          return MaterialPageRoute(
            builder: (context) => MeetupDetailScreen(meetupId: arguments.id)
          );
        }

        if (settings.name == LoginScreen.route) {
          final LoginScreenArguments arguments = settings.arguments;

          return MaterialPageRoute(
            builder: (context) => LoginScreen(message: arguments.message)
          );
        }
      }
    );
  }
}



