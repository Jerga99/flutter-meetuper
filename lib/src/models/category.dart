class Category {
  final String id;
  final String name;
  final String image;

  Category.fromJSON(Map<String, dynamic> parsedJson)
    : this.id = parsedJson['_id'],
      this.name = parsedJson['name'] ?? '',
      this.image = parsedJson['image'] ?? '';

}
