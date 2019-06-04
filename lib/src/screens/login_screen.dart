import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_meetuper/src/blocs/bloc_provider.dart';
import 'package:flutter_meetuper/src/models/forms.dart';
import 'package:flutter_meetuper/src/screens/meetup_home_screen.dart';
import 'package:flutter_meetuper/src/screens/register_screen.dart';
import 'package:flutter_meetuper/src/services/auth_api_service.dart';
import 'package:flutter_meetuper/src/utils/validators.dart';

class LoginScreen extends StatefulWidget {
  final String message;
  static final String route = '/login';
  final AuthApiService authApi = AuthApiService();

  LoginScreen({this.message});

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _emailKey = GlobalKey<FormFieldState<String>>();

  AuthBloc _authBloc;

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = false;
  BuildContext _scaffoldContext;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkForMessage());
    super.initState();
  }

  void _checkForMessage() {
    if (widget.message != null && widget.message.isNotEmpty) {
      Scaffold.of(_scaffoldContext).showSnackBar(SnackBar(
        content: Text(widget.message)
      ));
    }
  }

  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    _authBloc.dispatch(InitLogging());
    widget.authApi
      .login(_loginData)
      .then((data) {
        _authBloc.dispatch(LoggedIn());
      })
      .catchError((res) {
        _authBloc.dispatch(LoggedOut(message: res['errors']['message']));
      });
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _login();

    } else {
      setState(() => _autovalidate = true);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          _scaffoldContext = context;
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              autovalidate: _autovalidate,
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      'Login And Explore',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  TextFormField(
                    key: _emailKey,
                    style: Theme.of(context).textTheme.headline,
                    validator: composeValidators(
                                  'email',
                                  [requiredValidator, minLengthValidator, emailValidator]),
                    onSaved: (value) => _loginData.email = value,
                    decoration: InputDecoration(
                      hintText: 'Email Address'
                    ),
                  ),
                  TextFormField(
                    key: _passwordKey,
                    obscureText: true,
                    style: Theme.of(context).textTheme.headline,
                    validator: composeValidators(
                                  'password',
                                  [requiredValidator, minLengthValidator]),
                    onSaved: (value) => _loginData.password = value,
                    decoration: InputDecoration(
                      hintText: 'Password'
                    ),
                  ),
                  _buildLinks(),
                  Container(
                    alignment: Alignment(-1.0, 0.0),
                    margin: EdgeInsets.only(top: 10.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      child: const Text('Submit'),
                      onPressed: _submit,
                    )
                  )
                ],
              ),
            )
          );
        }
      ),
      appBar: AppBar(title: Text('Login')),
    );
  }

  Widget _buildLinks() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, RegisterScreen.route),
            child: Text(
              'Not Registered yet? Register Now!',
              style: TextStyle(
                color: Theme.of(context).primaryColor
              )
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, MeetupHomeScreen.route),
            child: Text(
              'Continue to Home Page',
              style: TextStyle(
                color: Theme.of(context).primaryColor
              )
            ),
          )
        ],
      )
    );
  }
}
