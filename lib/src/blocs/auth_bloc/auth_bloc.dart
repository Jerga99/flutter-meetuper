import 'package:flutter_meetuper/src/blocs/bloc_provider.dart';
import 'package:flutter_meetuper/src/blocs/auth_bloc/events.dart';
import 'package:flutter_meetuper/src/blocs/auth_bloc/states.dart';

export 'package:flutter_meetuper/src/blocs/auth_bloc/events.dart';
export 'package:flutter_meetuper/src/blocs/auth_bloc/states.dart';



class AuthBloc extends BlocBase {


  void dispatch(AuthenticationEvent event) async {
    await for (var state in _authStream(event)) {
      // provide state to other screen via controller
    }
  }


  Stream<AuthenticationState> _authStream(AuthenticationEvent event) async* {
    if (event is AppStarted) {
      // Check if user is authenticated
      final bool isAuth = false;

      if (isAuth) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }

      if (event is InitLogging) {
        yield AuthenticationLoading();
      }

      if (event is LoggedIn) {
        yield AuthenticationAuthenticated();
      }

      if (event is LoggedOut) {
        yield AuthenticationUnauthenticated();
      }
    }
  }

  dispose() {

  }
}
