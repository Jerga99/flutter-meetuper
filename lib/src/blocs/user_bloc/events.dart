import 'package:flutter_meetuper/src/models/meetup.dart';
import 'package:meta/meta.dart';

abstract class UserEvent {}

class CheckUserPermissionsOnMeetup extends UserEvent {
  Meetup meetup;

  CheckUserPermissionsOnMeetup({@required this.meetup});

  @override
  String toString() => 'CheckUserPermissionsOnMeetup';
}
