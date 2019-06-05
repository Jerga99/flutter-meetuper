import 'package:flutter/material.dart';
import 'package:flutter_meetuper/src/models/post.dart';
import 'package:flutter_meetuper/src/scoped_model/post_model.dart';
import 'package:flutter_meetuper/src/widgets/bottom_navigation.dart';
import 'package:scoped_model/scoped_model.dart';

class PostScreen extends StatefulWidget {

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  Widget build(BuildContext context) {

    return ScopedModel<PostModel>(
      model: PostModel(),
      child: _PostList()
    );
  }
}

class _PostList extends StatelessWidget {

  Widget build(BuildContext context) {
    return ScopedModelDescendant<PostModel>(
      builder: (context, _, model) {
        final posts = model.posts;
        return Scaffold(
          body: ListView.builder(
          itemCount: posts.length * 2,
          itemBuilder: (BuildContext context, int i) {
              if (i.isOdd) {
                return Divider();
              }

              final index = i ~/ 2;

              return ListTile(
                title: Text(posts[index].text),
                subtitle: Text(posts[index].body)
              );
            },
          ),
          bottomNavigationBar: BottomNavigation(),
          floatingActionButton: _PostButton(),
          appBar: AppBar(title: Text(model.testingState)),
        );
      },
    );
  }
}

class _PostButton extends StatelessWidget {
  Widget build(BuildContext context) {
    final postModel = ScopedModel.of<PostModel>(context, rebuildOnChange: true);
    return FloatingActionButton(
      onPressed: postModel.addPost,
      tooltip: 'Add Post',
      child: Icon(Icons.add)
    );
  }
}

class _InheritedPost extends InheritedWidget {
  final Widget child;
  final List<Post> posts;
  final Function createPost;

  _InheritedPost({@required this.child,
                  @required this.posts,
                  @required this.createPost}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static _InheritedPost of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedPost) as _InheritedPost);
  }
}
