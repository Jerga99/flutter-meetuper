abstract class UserState {}

class UserIsMember extends UserState {
  @override
  String toString() => 'UserIsMember';
}

class UserIsMeetupOwner extends UserState {
  @override
  String toString() => 'UserIsMeetupOwner';
}

class UserIsNotMember extends UserState {
  @override
  String toString() => 'UserIsNotMember';
}

class UserIsNotAuth extends UserState {
  @override
  String toString() => 'UserIsNotAuth';
}

class UserInitialState extends UserState {
  @override
  String toString() => 'UserInitialState';
}
