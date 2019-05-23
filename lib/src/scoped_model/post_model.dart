import 'package:faker/faker.dart';
import 'package:flutter_meetuper/src/models/post.dart';
import 'package:scoped_model/scoped_model.dart';

class PostModel extends Model {
  final List<Post> posts;
  final testingState = 'Testing State';

  PostModel({this.posts});

  addPost() {
    final id = faker.randomGenerator.integer(9999);
    final title = faker.food.dish();
    final body = faker.food.cuisine();
    final newPost = Post(title: title, body: body, id: id);

    posts.add(newPost);
    notifyListeners();
  }
}
