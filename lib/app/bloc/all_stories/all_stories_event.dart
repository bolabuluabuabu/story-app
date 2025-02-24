part of 'package:starter/app/bloc/all_stories/all_stories_bloc.dart';

abstract class AllStoriesEvent {}

class GetAllStoriesEvent extends AllStoriesEvent {}

class RefreshAllStoriesEvent extends AllStoriesEvent {}
