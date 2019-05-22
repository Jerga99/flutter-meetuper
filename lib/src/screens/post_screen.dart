import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/widgets/bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<dynamic> _posts = [];

  void initState() {
    super.initState();

    http.get('https://jsonplaceholder.typicode.com/posts')
      .then((res) {
        print(res.body);
        final posts = json.decode(res.body);
        print(posts);
        setState(() => _posts = posts);
      });
  }

  Widget build(BuildContext context) {
    print('I am calling Build!');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome In Posts Screen',
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 15.0)
            ),
          ],
        )
      ),
      bottomNavigationBar: BottomNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Increment',
        child: Icon(Icons.add)
      ),
      appBar: AppBar(title: Text('Posts')),
    );
  }
}

