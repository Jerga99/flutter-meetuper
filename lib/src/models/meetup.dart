import 'package:flutter_meetuper/src/models/category.dart';
import 'package:flutter_meetuper/src/models/user.dart';

class Meetup {
  final String id;
  final String processedLocation;
  final String location;
  final String title;
  final String image;
  final String description;
  final String shortInfo;
  final Category category;
  final String startDate;
  final String timeFrom;
  final String timeTo;
  final String createdAt;
  final String updatedAt;
  int joinedPeopleCount;
  final User meetupCreator;
  final List<User> joinedPeople;

  Meetup.fromJSON(Map<String, dynamic> parsedJson)
    : this.id = parsedJson['_id'],
      this.location = parsedJson['location'] ?? '',
      this.processedLocation = parsedJson['processedLocation'] ?? '',
      this.title = parsedJson['title'] ?? '',
      this.image = parsedJson['image'] ?? '',
      this.description = parsedJson['description'] ?? '',
      this.shortInfo = parsedJson['shortInfo'] ?? '',
      this.startDate = parsedJson['startDate'] ?? '',
      this.timeFrom = parsedJson['timeFrom'] ?? '',
      this.timeTo = parsedJson['timeTo'] ?? '',
      this.joinedPeopleCount = parsedJson['joinedPeopleCount'] ?? 0,
      this.createdAt = parsedJson['createdAt'] ?? '',
      this.updatedAt = parsedJson['updatedAt'] ?? '',
      this.category = Category.fromJSON(parsedJson['category']),
      this.meetupCreator = User.fromJSON(parsedJson['meetupCreator']),
      this.joinedPeople = parsedJson['joinedPeople'].map<User>((json) => User.fromJSON(json)).toList() ?? [];
}
