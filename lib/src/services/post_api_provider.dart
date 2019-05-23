import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_meetuper/src/models/post.dart';

class PostApiProvider {


  Future<List<Post>> fetchPosts() async {
    final res = await http.get('https://jsonplaceholder.typicode.com/posts');
    final List<dynamic> parsedPosts = json.decode(res.body);

    return parsedPosts.map((parsedPost) {
      return Post.fromJSON(parsedPost);
    }).toList();
  }
}
