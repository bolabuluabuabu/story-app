import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/bloc/all_stories/all_stories_bloc.dart';
import 'package:starter/app/bloc/auth/authentication_bloc.dart';
import 'package:starter/data/api_service/all_stories_service.dart';
import 'package:starter/data/model/story.dart';
import 'package:starter/design/scaffolds/scaffolds.dart';

class AllStoriesScreen extends StatelessWidget {
  const AllStoriesScreen({
    super.key,
    required this.onLoggedOut,
    required this.onCreateStory,
    required this.onTapStory,
    required this.passContext,
  });
  final Function() onLoggedOut, onCreateStory;
  final Function(String storyID) onTapStory;
  final Function(BuildContext context) passContext;

  @override
  Widget build(BuildContext context) {
    final auth = BlocProvider.of<AuthenticationBloc>(context).auth!;

    return BlocProvider(
      create: (context) {
        return AllStoriesBloc(AllStoriesService(auth))..add(GetAllStoriesEvent());
      },
      child: AllStoriesScreenBuilder(
        onCreateStory: onCreateStory,
        onLoggedOut: onLoggedOut,
        onTapStory: (s) {
          onTapStory(s.id);
        },
        passContext: passContext,
      ),
    );
  }
}

class AllStoriesScreenBuilder extends StatelessWidget {
  const AllStoriesScreenBuilder({
    super.key,
    required this.onLoggedOut,
    required this.onCreateStory,
    required this.onTapStory,
    required this.passContext,
  });

  final Function() onLoggedOut, onCreateStory;
  final Function(Story story) onTapStory;
  final Function(BuildContext context) passContext;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (ctx, authState) {
        if (authState is AuthenticationStateUnauthenticated) {
          onLoggedOut();
        }
      },
      child: BlocConsumer<AllStoriesBloc, AllStoriesState>(
        listener: (ctx, state) {
          passContext(context);
        },
        builder: (context, state) {
          if (state is SuccessAllStoriesState) {
            return AllStoriesScaffold(
              stories: state.stories,
              onAddButton: () {
                onCreateStory();
              },
              onTapStory: (s) {
                onTapStory(s);
              },
              onLogOut: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LogoutEvent());
              },
              onScrollMore: () {
                BlocProvider.of<AllStoriesBloc>(context).add(GetAllStoriesEvent());
              },
              isLoadingMore: state is SuccessAllStoriesStateWithLoading,
              isfetchedAll: state is SuccessAllStoriesStateFetchAll,
            );
          }

          if (state is ErrorAllStoriesState) {
            return ErrorSacffold(
              title: "All Stories",
              onReload: () {
                BlocProvider.of<AllStoriesBloc>(context).add(GetAllStoriesEvent());
              },
            );
          }

          return LoadingScaffold(title: "All Stories");
        },
      ),
    );
  }
}
