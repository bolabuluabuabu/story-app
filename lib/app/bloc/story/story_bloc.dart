import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter/data/api_service/story_service.dart';
import 'package:starter/data/model/story.dart';
part 'package:starter/app/bloc/story/story_event.dart';
part 'package:starter/app/bloc/story/story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final StoryService _storyService;

  StoryBloc(this._storyService) : super(StoryStateUninitialized()) {
    on<StoryEventGet>(_onStoryEvent);
    on<StoryEventCreate>(_onStoryEventCreate);
    on<StoryEventReset>(_onStoryEventReset);
    on<StoryEventUpdateLocation>(_onStoryEventUpdateLocation);
  }

  _onStoryEventUpdateLocation(StoryEventUpdateLocation event, Emitter<StoryState> emit) {
    emit(StoryStateUpdateLocation(latLng: event.latLng));
  }

  _onStoryEvent(StoryEventGet event, Emitter<StoryState> emit) async {
    try {
      emit(StoryStateLoading());

      final res = await _storyService.get(event.storyID);

      emit(StoryStateGet(story: res.story));
    } catch (e) {
      emit(StoryStateError());
    }
  }

  _onStoryEventCreate(StoryEventCreate event, Emitter<StoryState> emit) async {
    try {
      emit(StoryStateLoading());

      await _storyService.create(event.photo, event.description, event.latLng);

      emit(StoryStateCreate());
    } catch (e) {
      emit(StoryStateError());
    }
  }

  _onStoryEventReset(StoryEventReset event, Emitter<StoryState> emit) async {
    emit(StoryStateUninitialized());
  }
}
