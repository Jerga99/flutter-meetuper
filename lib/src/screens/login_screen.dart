import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {

  static final String route = '/login';

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _emailKey = GlobalKey<FormFieldState<String>>();

  _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      final password = _passwordKey.currentState.value;
      final email = _emailKey.currentState.value;

      print('password is: $password, email is: $email');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
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
                decoration: InputDecoration(
                  hintText: 'Email Address'
                ),
              ),
              TextFormField(
                key: _passwordKey,
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(
                  hintText: 'Password'
                ),
              ),
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
      ),
      appBar: AppBar(title: Text('Login')),
    );
  }
}
