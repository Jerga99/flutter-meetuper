import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/blocs/bloc_provider.dart';
import 'package:flutter_meetuper/src/blocs/meetup_bloc.dart';
import 'package:flutter_meetuper/src/blocs/user_bloc/user_bloc.dart';
import 'package:flutter_meetuper/src/models/meetup.dart';
import 'package:flutter_meetuper/src/services/auth_api_service.dart';
import 'package:flutter_meetuper/src/services/meetup_api_service.dart';
import 'package:flutter_meetuper/src/widgets/bottom_navigation.dart';

class MeetupDetailScreen extends StatefulWidget {
  static final String route = '/meetupDetail';
  final String meetupId;
  final MeetupApiService api = MeetupApiService();

  MeetupDetailScreen({this.meetupId});

  @override
  _MeetupDetailScreenState createState() => _MeetupDetailScreenState();
}

class _MeetupDetailScreenState extends State<MeetupDetailScreen> {
  MeetupBloc _meetupBloc;
  UserBloc _userBloc;

  void initState(){
    _meetupBloc = BlocProvider.of<MeetupBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);

    _meetupBloc.fetchMeetup(widget.meetupId);
    _meetupBloc.meetup.listen((meetup) {
      _userBloc.dispatch(CheckUserPermissionsOnMeetup(meetup: meetup));
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return StreamBuilder<UserState>(
      stream: _userBloc.userState,
      initialData: UserInitialState(),
      builder: (BuildContext context, AsyncSnapshot<UserState> snapshot) {
        final userState = snapshot.data;
        return Scaffold(
          body: StreamBuilder<Meetup>(
            stream: _meetupBloc.meetup,
            builder: (BuildContext context, AsyncSnapshot<Meetup> snapshot) {
              if (snapshot.hasData) {
                final meetup = snapshot.data;
                return ListView(
                  children: <Widget>[
                    HeaderSection(meetup),
                    TitleSection(meetup),
                    AdditionalInfoSection(meetup),
                    Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
                          'Alps. Situated 1,578 meters above sea level, it is one of the '
                          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
                          'half-hour walk through pastures and pine forest, leads you to the '
                          'lake, which warms to 20 degrees Celsius in the summer. Activities '
                          'enjoyed here include rowing, and riding the summer toboggan run.'
                        )
                      )
                    )
                  ],
                );
              } else {
                return Container(width: 0, height: 0);
              }
            },
          ),
          appBar: AppBar(title: Text('Meetup Detail')),
          bottomNavigationBar: BottomNavigation(),
          floatingActionButton: _MeetupActionButton(userState: userState),
        );
      }
    );
  }
}

class _MeetupActionButton extends StatelessWidget {
  final AuthApiService auth = AuthApiService();
  final UserState userState;

  _MeetupActionButton({@required this.userState});

  Widget build(BuildContext context) {
      if (userState is UserIsMember) {
        return FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.cancel),
          backgroundColor: Colors.red,
          tooltip: 'Leave Meetup',
        );
      } else if (userState is UserIsNotMember) {
        return FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.person_add),
          backgroundColor: Colors.green,
          tooltip: 'Join Meetup',
        );
      } else {
      return Container(width: 0, height: 0);
    }
  }
}

class AdditionalInfoSection extends StatelessWidget {
  final Meetup meetup;

  AdditionalInfoSection(this.meetup);

  String _capitilize(String word) {
    return (word != null && word.isNotEmpty)
     ? word[0].toUpperCase() + word.substring(1)
     : '';
  }

  Widget _buildColumn(String label, String text, Color color) {
    return Column(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
            color: color
          )
        ),
        Text(
          _capitilize(text),
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
            color: color
          )
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildColumn('CATEGORY', meetup.category.name, color),
        _buildColumn('FROM', meetup.timeFrom, color),
        _buildColumn('TO', meetup.timeTo, color)
      ],
    );
  }
}

class TitleSection extends StatelessWidget {
  final Meetup meetup;

  TitleSection(this.meetup);

  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  meetup.title,
                  style: TextStyle(fontWeight: FontWeight.bold)
                ),
                Text(
                  meetup.shortInfo,
                  style: TextStyle(color: Colors.grey[500])
                )
              ],
            ),
          ),
          Icon(
            Icons.people,
            color: color
          ),
          Text('${meetup.joinedPeopleCount} People')
        ],
      )
    );
  }
}


class HeaderSection extends StatelessWidget {
  final Meetup meetup;

  HeaderSection(this.meetup);

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        Image.network(meetup.image, width: width, height: 240.0, fit: BoxFit.cover),
        Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3)
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage('https://cdn1.vectorstock.com/i/thumb-large/82/55/anonymous-user-circle-icon-vector-18958255.jpg'),
              ),
              title: Text(
                meetup.title,
                style: TextStyle(
                  fontSize:  20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                )
              ),
              subtitle: Text(
                meetup.shortInfo,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                )
              ),
            ),
          )
        )
      ],
    );
  }
}
