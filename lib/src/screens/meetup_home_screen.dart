
import 'dart:math';

import 'package:flutter/material.dart';


class MeetupHomeScreen extends StatefulWidget {
  MeetupHomeScreenState createState() => MeetupHomeScreenState();
}

class MeetupHomeScreenState extends State<MeetupHomeScreen> {

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _MeetupTitle(),
          _MeetupList()
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
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1512136146408-dab5f2ba8ebb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1567&q=80'),
            ),
            title: Text('Meetup in New York'),
            subtitle: Text('Just some meetup description')
          ),
          ButtonTheme.bar(
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('Visit Meetup'),
                  onPressed: () {}
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
  final List<_MeetupCard> meetupCardList
    = [_MeetupCard(),_MeetupCard(),_MeetupCard(),_MeetupCard(),_MeetupCard(),_MeetupCard()];

  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: meetupCardList.length * 2,
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;

          return meetupCardList[index];
        },
      )
    );
  }
}






