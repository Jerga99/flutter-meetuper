

abstract class AuthenticationEvent {  }

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class InitLogging extends AuthenticationEvent {
  @override
  String toString() => 'InitLogging';
}

class LoggedIn extends AuthenticationEvent {
  @override
  String toString() => 'LoggedIn';
}

class LoggedOut extends AuthenticationEvent {
  String message;

  LoggedOut({this.message});

  @override
  String toString() => 'LoggedOut';
}
