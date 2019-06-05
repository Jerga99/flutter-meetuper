// ------- THREAD -----------

// class Thread {
//   final String title;
//   final User user;
//   final String updatedAt;
//   final List<Post> posts;

//   Thread.fromJSON(Map<String, dynamic> parsedJson)
//     : this.title = parsedJson['title'],
//       this.user = User.fromJSON(parsedJson['user']),
//       this.updatedAt = parsedJson['updatedAt'],
//       this.posts = parsedJson['posts'].map<Post>((json) => Post.fromJSON(json)).toList() ?? [];
// }

// ------- POST -----------

// class Post {
//   final String text;
//   final String body;
//   final int id;
//   final User user;
//   final String updatedAt;

//   Post({String text, String body, num id, this.user, this.updatedAt})
//     : this.text = text,
//       this.body = body,
//       this.id = id;

//   Post.fromJSON(Map<String, dynamic> parsedJson)
//     : this.text = parsedJson['text'],
//       this.body = parsedJson['body'],
//       this.updatedAt = parsedJson['updatedAt'],
//       this.id = parsedJson['id'],
//       this.user = User.fromJSON(parsedJson['user']);
// }

// ------- FETCH THREADS -----------

// Future<List<Thread>> fetchThreads(String meetupId) async {
//     final res = await http.get('$url/threads?meetupId=$meetupId');
//     final Map<String, dynamic> parsedBody = json.decode(res.body);
//     List<dynamic> parsedThreads = parsedBody['threads'];
//     return parsedThreads.map((val) => Thread.fromJSON(val)).toList();
//   }
