import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {

  static final String route = '/login';

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          // Provide key
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
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(
                  hintText: 'Email Address'
                ),
              ),
              TextFormField(
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
                  onPressed: () => {},
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
