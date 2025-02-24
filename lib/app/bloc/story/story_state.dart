part of 'package:starter/app/bloc/story/story_bloc.dart';

abstract class StoryState {}

class StoryStateUninitialized extends StoryState {}

class StoryStateGet extends StoryState {
  final Story story;

  StoryStateGet({required this.story});
}

class StoryStateCreate extends StoryState {}

class StoryStateLoading extends StoryState {}

class StoryStateError extends StoryState {}

class StoryStateUpdateLocation extends StoryState {
  final LatLng latLng;

  StoryStateUpdateLocation({required this.latLng});
}
