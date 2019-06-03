import 'dart:async';

import 'package:flutter_meetuper/src/blocs/bloc_provider.dart';
import 'package:flutter_meetuper/src/blocs/user_bloc/events.dart';
import 'package:flutter_meetuper/src/blocs/user_bloc/states.dart';
import 'package:flutter_meetuper/src/models/meetup.dart';
import 'package:flutter_meetuper/src/models/user.dart';
import 'package:flutter_meetuper/src/services/auth_api_service.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';

export 'package:flutter_meetuper/src/blocs/user_bloc/events.dart';
export 'package:flutter_meetuper/src/blocs/user_bloc/states.dart';

class UserBloc extends BlocBase {
  final AuthApiService auth;

  final BehaviorSubject<UserState> _userSubject = BehaviorSubject<UserState>();
  Stream<UserState> get userState => _userSubject.stream;
  StreamSink<UserState> get _inUserState => _userSubject.sink;

  UserBloc({@required this.auth}): assert(auth != null);

  void dispatch(UserEvent event) async {
    await for(var state in _userStream(event)) {
      _inUserState.add(state);
    }
  }

  Stream<UserState> _userStream(UserEvent event) async* {
    if (event is CheckUserPermissionsOnMeetup) {
      final bool isAuth = await auth.isAuthenticated();
      if (isAuth) {
        final User user = auth.authUser;
        final meetup = event.meetup;

        if (_isUserMeetupOwner(meetup, user)) {
          yield UserIsMeetupOwner();
          return;
        }

        if (_isUserJoinedInMeetup(meetup, user)) {
          yield UserIsMember();
        } else {
          yield UserIsNotMember();
        }

      } else {
        yield UserIsNotAuth();
      }
    }
  }

  bool _isUserMeetupOwner(Meetup meetup, User user) {
    return user != null && meetup.meetupCreator.id == user.id;
  }

  bool _isUserJoinedInMeetup(Meetup meetup, User user) {
    return user != null &&
           user.joinedMeetups.isNotEmpty &&
           user.joinedMeetups.contains(meetup.id);
  }

  dispose() {
    _userSubject.close();
  }
}
