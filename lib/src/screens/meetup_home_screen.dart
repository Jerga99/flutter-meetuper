
import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/models/meetup.dart';
import 'package:flutter_meetuper/src/screens/meetup_detail_screen.dart';
import 'package:flutter_meetuper/src/services/meetup_api_service.dart';


class MeetupHomeScreen extends StatefulWidget {
  final MeetupApiService _api = MeetupApiService();

  MeetupHomeScreenState createState() => MeetupHomeScreenState();
}

class MeetupHomeScreenState extends State<MeetupHomeScreen> {
  List<Meetup> meetups = [];

  @override
  initState() {
    super.initState();
    _fetchMeetups();
  }

  _fetchMeetups() async {
    final meetups = await widget._api.fetchMeetups();
    setState(() => this.meetups = meetups);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _MeetupTitle(),
          _MeetupList(meetups: meetups)
        ],
      ),
      appBar: AppBar(
        title: Text('Home')
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){},
      ),
    );
  }
}

class _MeetupTitle extends StatelessWidget {

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20.0),
      child: Text('Featured Meetup', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
    );
  }
}

class _MeetupCard extends StatelessWidget {
  final Meetup meetup;

  _MeetupCard({@required this.meetup});

  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(meetup.image),
            ),
            title: Text(meetup.title),
            subtitle: Text(meetup.description)
          ),
          ButtonTheme.bar(
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('Visit Meetup'),
                  onPressed: () {
                    Navigator.pushNamed(context, MeetupDetailScreen.route);
                  }
                ),
                FlatButton(
                  child: Text('Favorite'),
                  onPressed: () {}
                )
              ],
            )
          )
        ],
      )
    );
  }
}

class _MeetupList extends StatelessWidget {
  final List<Meetup> meetups;

  _MeetupList({@required this.meetups});

  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: meetups.length * 2,
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;

          return _MeetupCard(meetup: meetups[index]);
        },
      )
    );
  }
}






