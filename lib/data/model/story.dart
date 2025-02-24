import 'package:json_annotation/json_annotation.dart';

part 'story.g.dart';

@JsonSerializable()
class Story {
  String id;
  String name;
  String description;
  String photoUrl;
  @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimetoJson)
  DateTime createdAt;
  double? lat;
  double? lon;

  Story({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });

  static DateTime dateTimeFromJson(String data) {
    return DateTime.parse(data);
  }

  static String dateTimetoJson(DateTime data) {
    return data.toIso8601String();
  }

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);
}
