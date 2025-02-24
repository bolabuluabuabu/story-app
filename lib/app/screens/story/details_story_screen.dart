import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/bloc/all_stories/all_stories_bloc.dart';
import 'package:starter/app/bloc/auth/authentication_bloc.dart';
import 'package:starter/app/bloc/story/story_bloc.dart';
import 'package:starter/data/api_service/story_service.dart';
import 'package:starter/design/scaffolds/details_story_scaffold.dart';
import 'package:starter/design/scaffolds/error_scaffold.dart';
import 'package:starter/design/scaffolds/loading_scaffold.dart';

class DetailsStoryScreen extends StatelessWidget {
  const DetailsStoryScreen({super.key, required this.prevContext, required this.storyID});
  final BuildContext prevContext;
  final String storyID;

  static MaterialPageRoute route(BuildContext prevContext, String sroryID) {
    return MaterialPageRoute(
      builder: (context) => DetailsStoryScreen(prevContext: prevContext, storyID: sroryID),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = BlocProvider.of<AuthenticationBloc>(context).auth!;

    return MultiBlocProvider(
      providers: [
        BlocProvider<StoryBloc>(
          create: (context) => StoryBloc(StoryService(auth))..add(StoryEventGet(storyID: storyID)),
        ),
        BlocProvider.value(value: BlocProvider.of<AllStoriesBloc>(prevContext))
      ],
      child: DetailsStoryScreenBuilder(storyID: storyID),
    );
  }
}

class DetailsStoryScreenBuilder extends StatelessWidget {
  const DetailsStoryScreenBuilder({super.key, required this.storyID});
  final String storyID;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryBloc, StoryState>(
      builder: (context, state) {
        if (state is StoryStateGet) {
          return Container(
            child: DetailsStoryScaffold(story: state.story),
          );
        }

        if (state is StoryStateError) {
          return ErrorSacffold(
            title: "Story Details",
            onReload: () {
              BlocProvider.of<StoryBloc>(context).add(
                StoryEventGet(storyID: storyID),
              );
            },
          );
        }

        return const LoadingScaffold(title: "Story Details");
      },
    );
  }
}
