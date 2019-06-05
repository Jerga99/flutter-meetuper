
import 'package:flutter_meetuper/src/models/category.dart';
import 'package:flutter_meetuper/src/models/forms.dart';
import 'package:flutter_meetuper/src/models/meetup.dart';
import 'package:flutter_meetuper/src/models/thread.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:shared_preferences/shared_preferences.dart';


class MeetupApiService {
  // final String url = Platform.isIOS ? 'http://localhost:3001/api/v1' : 'http://10.0.2.2:3001/api/v1';
  final String url = 'https://flutter-meetuper-server.herokuapp.com/api/v1';
  static final MeetupApiService _singleton = MeetupApiService._internal();

  factory MeetupApiService() {
    return _singleton;
  }
  MeetupApiService._internal();

  Future<List<Meetup>> fetchMeetups() async {
    final res = await http.get('$url/meetups');

    final List parsedMeetups = json.decode(res.body);
    return parsedMeetups.map((val) => Meetup.fromJSON(val)).toList();
  }

  Future<Meetup> fetchMeetupById(String id) async {
    final res = await http.get('$url/meetups/$id');
    final parsedMeetup = json.decode(res.body);
    return Meetup.fromJSON(parsedMeetup);
  }

  Future<List<Category>> fetchCategories() async {
    final res = await http.get('$url/categories');
    final List decodedBody = json.decode(res.body);
    return decodedBody.map((val) => Category.fromJSON(val)).toList();
  }

  Future<List<Thread>> fetchThreads(String meetupId) async {
    final res = await http.get('$url/threads?meetupId=$meetupId');
    final Map<String, dynamic> parsedBody = json.decode(res.body);
    List<dynamic> parsedThreads = parsedBody['threads'];
    return parsedThreads.map((val) => Thread.fromJSON(val)).toList();
  }

  Future<String> createMeetup(MeetupFormData formData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final body = json.encode(formData.toJSON());
    final Map<String, String> headers
       = {'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'};
    final res = await http.post('$url/meetups', headers: headers, body: body);

    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      return Future.error(res.body);
    }
  }

  Future<bool> joinMeetup(String meetupId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      await http.post('$url/meetups/$meetupId/join',
                      headers: {'Authorization': 'Bearer $token'});
      return true;
    } catch(e) {
      throw Exception('Cannot join meetup!');
    }
  }

  Future<bool> leaveMeetup(String meetupId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      await http.post('$url/meetups/$meetupId/leave',
                      headers: {'Authorization': 'Bearer $token'});
      return true;
    } catch(e) {
      throw Exception('Cannot leave meetup!');
    }
  }

}
