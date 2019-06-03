import 'package:flutter_meetuper/src/blocs/bloc_provider.dart';
import 'package:flutter_meetuper/src/blocs/user_bloc/events.dart';
import 'package:flutter_meetuper/src/blocs/user_bloc/states.dart';

export 'package:flutter_meetuper/src/blocs/user_bloc/events.dart';
export 'package:flutter_meetuper/src/blocs/user_bloc/states.dart';

class UserBloc extends BlocBase {

  Stream<UserState> _userStream(UserEvent event) async* {

    if (event is CheckUserPermissionsOnMeetup) {
      // change it for auctual auth
      final bool isAuth = false;
      if (isAuth) {
        // Get here actual user
        final User user = null;
        final meetup = event.meetup;

        if (isUserMeetupOwner()) {
          yield UserIsMeetupOwner();
          return;
        }

        if (isUserJoinedInMeetup()) {
          yield UserIsMember();
        } else {
          yield UserIsNotMember();
        }

      } else {
        yield UserIsNotAuth();
      }
    }
  }

  bool _isUserMeetupOwner() {
    return false;
  }

  bool _isUserJoinedInMeetup() {
    return false;
  }


  dispose() {

  }
}
