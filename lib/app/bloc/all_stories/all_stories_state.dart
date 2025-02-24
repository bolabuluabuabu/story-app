part of 'package:starter/app/bloc/all_stories/all_stories_bloc.dart';

abstract class AllStoriesState {}

class UninitializedAllStoriesState extends AllStoriesState {}

class ErrorAllStoriesState extends AllStoriesState {}

class LoadingAllStoriesState extends AllStoriesState {}

class SuccessAllStoriesState extends AllStoriesState {
  final List<Story> stories;
  final int currentPage;

  SuccessAllStoriesState({required this.stories, required this.currentPage});
}

class SuccessAllStoriesStateWithError extends SuccessAllStoriesState {
  SuccessAllStoriesStateWithError({required super.stories, required super.currentPage});
}

class SuccessAllStoriesStateWithLoading extends SuccessAllStoriesState {
  SuccessAllStoriesStateWithLoading({required super.stories, required super.currentPage});
}

class SuccessAllStoriesStateFetchAll extends SuccessAllStoriesState {
  SuccessAllStoriesStateFetchAll({required super.stories, required super.currentPage});
}
