import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/models/post.dart';
import 'package:flutter_meetuper/src/services/post_api_provider.dart';
import 'package:flutter_meetuper/src/widgets/bottom_navigation.dart';

class PostScreen extends StatefulWidget {
  final PostApiProvider _api = PostApiProvider();

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Post> _posts = [];

  void initState() {
    super.initState();
    _fetchPosts();
  }

  _fetchPosts() async {
    List<Post> posts = await widget._api.fetchPosts();
    setState(() => _posts = posts);
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
  final List<Post> _posts;

  _PostList({@required List<Post> posts}): _posts = posts;

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _posts.length * 2,
      itemBuilder: (BuildContext context, int i) {
        if (i.isOdd) {
          return Divider();
        }

        final index = i ~/ 2;

        return ListTile(
          title: Text(_posts[index].title),
          subtitle: Text(_posts[index].body)
        );
      },
    );
  }
}
