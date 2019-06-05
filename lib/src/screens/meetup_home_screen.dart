
import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_meetuper/src/blocs/bloc_provider.dart';
import 'package:flutter_meetuper/src/blocs/meetup_bloc.dart';
import 'package:flutter_meetuper/src/models/meetup.dart';
import 'package:flutter_meetuper/src/screens/login_screen.dart';
import 'package:flutter_meetuper/src/screens/meetup_detail_screen.dart';
import 'package:flutter_meetuper/src/screens/meetup_create_screen.dart';
import 'package:flutter_meetuper/src/screens/register_screen.dart';
import 'package:flutter_meetuper/src/services/auth_api_service.dart';

class MeetupDetailArguments {
  final String id;

  MeetupDetailArguments({this.id});
}

class MeetupHomeScreen extends StatefulWidget {
  static final String route = '/meetups';
  MeetupHomeScreenState createState() => MeetupHomeScreenState();
}

class MeetupHomeScreenState extends State<MeetupHomeScreen> {
  List<Meetup> meetups = [];
  AuthBloc authBloc;

  void initState() {
    BlocProvider.of<MeetupBloc>(context).fetchMeetups();
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  _showBottomMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => _ModalBottomSheet(authBloc: authBloc)
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _MeetupTitle(authBloc: authBloc),
          _MeetupList()
        ],
      ),
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _showBottomMenu(context),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, MeetupCreateScreen.route);
        },
      ),
    );
  }
}

class _MeetupTitle extends StatelessWidget {
  final AuthApiService auth = AuthApiService();
  final AuthBloc authBloc;

  _MeetupTitle({@required this.authBloc});

  Widget _buildUserWelcome() {
    return FutureBuilder<bool>(
      future: auth.isAuthenticated(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data) {
          final user = auth.authUser;
          return Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                user.avatar != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    )
                  : Container(width: 0, height: 0),
                Text('Welcome ${user.username}'),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    auth.logout()
                      .then((isLogout) => authBloc.dispatch(LoggedOut(message: 'You have been succefuly logged out!')));
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor
                    )
                  ),
                )
              ],
            )
          );
        } else {
          return Container(width: 0, height: 0);
        }
      },
    );
  }

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Featured Meetups', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
          _buildUserWelcome()
        ]
      )
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
              radius: 25.0,
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
                    Navigator.pushNamed(context, MeetupDetailScreen.route, arguments: MeetupDetailArguments(id: meetup.id));
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
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<Meetup>>(
        stream: BlocProvider.of<MeetupBloc>(context).meetups,
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List<Meetup>> snapshot) {
          var meetups = snapshot.data;
          return ListView.builder(
            itemCount: meetups.length * 2,
            itemBuilder: (BuildContext context, int i) {
              if (i.isOdd) return Divider();
              final index = i ~/ 2;

              return _MeetupCard(meetup: meetups[index]);
            },
          );
        },
      )
    );
  }
}


class _ModalBottomSheet extends StatelessWidget {
  final AuthBloc authBloc;
  final AuthApiService auth = AuthApiService();

  _ModalBottomSheet({@required this.authBloc}): assert(authBloc != null);

  Widget build(BuildContext context) {
    return StreamBuilder<AuthenticationState>(
      stream: authBloc.authState,
      initialData: AuthenticationUninitialized(),
      builder: (BuildContext context, AsyncSnapshot<AuthenticationState> snapshot) {
        final state = snapshot.data;

        if (state is AuthenticationUninitialized) {
          return Container(width: 0, height: 0);
        }

        if (state is AuthenticationAuthenticated) {
          return Container(
            height: 150.0,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_album),
                  title: Text('Create Meetup'),
                  onTap: () => {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      MeetupCreateScreen.route,
                      ModalRoute.withName('/'))
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Logout'),
                  onTap: () =>
                   auth.logout()
                      .then((isLogout) {
                        Navigator.pop(context);
                        authBloc.dispatch(LoggedOut(message: 'You have been succefuly logged out!'));
                    }
                  )
                ),
              ],
            ),
          );
        }

        if (state is AuthenticationUnauthenticated) {
          return Container(
            height: 150.0,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: new Icon(Icons.person),
                  title: new Text('Login'),
                  onTap: () => {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginScreen.route,
                      ModalRoute.withName(MeetupHomeScreen.route))
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.person),
                  title: new Text('Register'),
                  onTap: () => {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RegisterScreen.route,
                      ModalRoute.withName(MeetupHomeScreen.route))
                  },
                )
              ],
            ),
          );
        }
      }
    );
  }
}




