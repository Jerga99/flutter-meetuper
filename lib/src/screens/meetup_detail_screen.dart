import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/models/meetup.dart';
import 'package:flutter_meetuper/src/services/meetup_api_service.dart';
import 'package:flutter_meetuper/src/widgets/bottom_navigation.dart';

class MeetupDetailScreen extends StatefulWidget {
  static final String route = '/meetupDetail';
  final String meetupId;
  final MeetupApiService api = MeetupApiService();

  MeetupDetailScreen({this.meetupId});

  @override
  MeetupDetailScreenState createState() => MeetupDetailScreenState();
}

class MeetupDetailScreenState extends State<MeetupDetailScreen> {
  Meetup meetup;

  initState() {
    super.initState();
    _fetchMeetup();
  }

  _fetchMeetup() async {
    final meetup = await widget.api.fetchMeetupById(widget.meetupId);
    setState(() => this.meetup = meetup);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          HeaderSection(meetup: meetup),
        ],
      ),
      appBar: AppBar(title: Text('Meetup Detail')),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}


class HeaderSection extends StatelessWidget {
  final Meetup meetup;

  HeaderSection({this.meetup});

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.network(meetup.image, width: 640.0, height: 240.0, fit: BoxFit.cover)
      ],
    );
  }
}
