part of 'package:starter/app/bloc/story/story_bloc.dart';

abstract class StoryEvent {}

class StoryEventGet extends StoryEvent {
  final String storyID;

  StoryEventGet({required this.storyID});
}

class StoryEventUpdateLocation extends StoryEvent {
  final LatLng latLng;

  StoryEventUpdateLocation({required this.latLng});
}

class StoryEventCreate extends StoryEvent {
  final File photo;
  final String description;
  final LatLng? latLng;

  StoryEventCreate({required this.photo, required this.description, required this.latLng});
}

class StoryEventReset extends StoryEvent {}
