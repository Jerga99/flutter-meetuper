import 'package:flutter/material.dart';



class MeetupHomeScreen extends StatefulWidget {
  MeetupHomeScreenState createState() => MeetupHomeScreenState();
}

class MeetupHomeScreenState extends State<MeetupHomeScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('I am Meetup Home Screen'),
      ),
      appBar: AppBar(
        title: Text('Home')
      )
    );
  }
}
