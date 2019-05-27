import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/widgets/bottom_navigation.dart';

class MeetupDetailScreen extends StatelessWidget {
  static final String route = '/meetupDetail';
  final String meetupId;

  MeetupDetailScreen({this.meetupId});

  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(meetupId),
      appBar: AppBar(title: Text('Meetup Detail')),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
