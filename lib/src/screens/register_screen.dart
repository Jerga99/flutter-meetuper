import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {

  static final String route = '/register';

  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  Widget build(BuildContext context) {
    return Scaffold(
      body: FlatButton(
        child: Text('Go To Login Screen'),
        onPressed: () => Navigator.pushNamed(context, LoginScreen.route),
      ),
      appBar: AppBar(title: Text('Register')),
    );
  }
}
