
class Post {
  final String title;
  final String body;
  final int id;

  Post({String title, String body, int id})
    : this.title = title,
      this.body = body,
      this.id = id;

  Post.fromJSON(Map<String, dynamic> parsedJson)
    : title = parsedJson['title'],
      body = parsedJson['body'],
      id = parsedJson['id'];
}
