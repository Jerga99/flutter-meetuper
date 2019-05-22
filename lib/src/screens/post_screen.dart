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
    _fetchPosts();
  }

  void _fetchPosts() {
    http.get('https://jsonplaceholder.typicode.com/posts')
      .then((res) {
        final posts = json.decode(res.body);
        setState(() => _posts = posts);
      });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _PostList(posts: _posts),
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


class _PostList extends StatelessWidget {
  final List<dynamic> _posts;

  _PostList({@required List<dynamic> posts}): _posts = posts;

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _posts.length * 2,
      itemBuilder: (BuildContext context, int i) {
        if (i.isOdd) {
          return Divider();
        }

        final index = i ~/ 2;

        return ListTile(
          title: Text(_posts[index]['title']),
          subtitle: Text(_posts[index]['body'])
        );
      },
    );
  }
}
