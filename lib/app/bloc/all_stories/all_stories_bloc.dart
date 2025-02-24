import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/data/api_service/all_stories_service.dart';
import 'package:starter/data/model/story.dart';

part 'package:starter/app/bloc/all_stories/all_stories_event.dart';
part 'package:starter/app/bloc/all_stories/all_stories_state.dart';

class AllStoriesBloc extends Bloc<AllStoriesEvent, AllStoriesState> {
  final AllStoriesService _allStoriesService;

  AllStoriesBloc(this._allStoriesService) : super(UninitializedAllStoriesState()) {
    on<GetAllStoriesEvent>(_onGetStoriesEvent);
    on<RefreshAllStoriesEvent>(_onRefresh);
  }

  _onRefresh(RefreshAllStoriesEvent event, Emitter<AllStoriesState> emit) async {
    emit(UninitializedAllStoriesState());

    add(GetAllStoriesEvent());
  }

  _onGetStoriesEvent(GetAllStoriesEvent event, Emitter<AllStoriesState> emit) async {
    if (state is SuccessAllStoriesStateFetchAll) return;

    try {
      if (state is SuccessAllStoriesState) {
        emit(SuccessAllStoriesStateWithLoading(
          stories: (state as SuccessAllStoriesState).stories,
          currentPage: (state as SuccessAllStoriesState).currentPage,
        ));
      } else {
        emit(LoadingAllStoriesState());
      }

      final res = await _allStoriesService.get(page: state is SuccessAllStoriesState ? (state as SuccessAllStoriesState).currentPage + 1 : 1, size: 10);

      if (res.error) {
        if (state is SuccessAllStoriesState) {
          emit(SuccessAllStoriesStateWithError(
            stories: (state as SuccessAllStoriesState).stories,
            currentPage: (state as SuccessAllStoriesState).currentPage,
          ));
        } else {
          emit(ErrorAllStoriesState());
        }
      } else {
        if (res.listStory.isEmpty) {
          emit(SuccessAllStoriesStateFetchAll(
            stories: state is SuccessAllStoriesState ? (state as SuccessAllStoriesState).stories + res.listStory : res.listStory,
            currentPage: state is SuccessAllStoriesState ? (state as SuccessAllStoriesState).currentPage : 1,
          ));
        } else {
          emit(SuccessAllStoriesState(
            stories: state is SuccessAllStoriesState ? (state as SuccessAllStoriesState).stories + res.listStory : res.listStory,
            currentPage: state is SuccessAllStoriesState ? (state as SuccessAllStoriesState).currentPage + 1 : 1,
          ));
        }
      }
    } catch (e) {
      emit(ErrorAllStoriesState());
    }
  }
}
