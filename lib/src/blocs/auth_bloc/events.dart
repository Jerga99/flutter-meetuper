

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
  @override
  String toString() => 'LoggedOut';
}
