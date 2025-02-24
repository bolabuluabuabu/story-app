import 'package:json_annotation/json_annotation.dart';
import 'package:starter/data/model/story.dart';

part 'all_stories_response.g.dart';

@JsonSerializable()
class AllStoriesResponse {
  bool error;
  String message;
  List<Story> listStory;

  AllStoriesResponse({
    required this.error,
    required this.message,
    required this.listStory,
  });

  factory AllStoriesResponse.fromJson(Map<String, dynamic> json) => _$AllStoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllStoriesResponseToJson(this);
}
