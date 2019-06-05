


import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/blocs/meetup_bloc.dart';
import 'package:flutter_meetuper/src/models/thread.dart';

class ThreadList extends StatelessWidget {

  final MeetupBloc bloc;

  ThreadList({@required this.bloc}): assert(bloc != null);

  Widget build(BuildContext context) {
    return StreamBuilder<List<Thread>>(
      stream: bloc.threads,
      builder: (BuildContext context, AsyncSnapshot<List<Thread>> snapshot) {
        if (snapshot.hasData) {
          final threads = snapshot.data;
          return ListView(
            children: threads.map((thread) => Text(thread.title)).toList()
          );
        } else {
          return Center(
            child: CircularProgressIndicator()
          );
        }
      }
    );
  }
}
