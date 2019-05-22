import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/widgets/bottom_navigation.dart';

class MeetupDetailScreen extends StatelessWidget {
  static final String route = '/meetupDetail';

  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('I am Meetup Detail Screen'),
      appBar: AppBar(title: Text('Meetup Detail')),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
