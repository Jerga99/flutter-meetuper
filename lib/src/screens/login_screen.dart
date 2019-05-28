import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {

  static final String route = '/login';

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Widget build(BuildContext context) {
    return Scaffold(
      body: FlatButton(
        child: Text('Go To Register Screen'),
        onPressed: () => Navigator.pushNamed(context, RegisterScreen.route),
      ),
      appBar: AppBar(title: Text('Login')),
    );
  }
}
