import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/bloc/all_stories/all_stories_bloc.dart';
import 'package:starter/app/bloc/auth/authentication_bloc.dart';
import 'package:starter/app/bloc/story/story_bloc.dart';
import 'package:starter/data/api_service/story_service.dart';
import 'package:starter/design/bloc/button/design_bloc.dart';
import 'package:starter/design/scaffolds/create_story_scaffold.dart';

class CreateStoryScreen extends StatelessWidget {
  const CreateStoryScreen({
    super.key,
    required this.prevContext,
    required this.onCreatedStroy,
    required this.onAddLocation,
    required this.passContext,
  });
  final BuildContext prevContext;
  final Function() onCreatedStroy, onAddLocation;
  final Function(BuildContext context) passContext;

  @override
  Widget build(BuildContext context) {
    final auth = BlocProvider.of<AuthenticationBloc>(context).auth!;

    return MultiBlocProvider(
      providers: [
        BlocProvider<StoryBloc>(
          create: (context) => StoryBloc(StoryService(auth)),
        ),
        BlocProvider.value(value: BlocProvider.of<AllStoriesBloc>(prevContext))
      ],
      child: CreateStoryScreenBuilder(
        onCreatedStroy: onCreatedStroy,
        onAddLocation: onAddLocation,
        passContext: passContext,
      ),
    );
  }
}

class CreateStoryScreenBuilder extends StatelessWidget {
  const CreateStoryScreenBuilder({
    super.key,
    required this.onCreatedStroy,
    required this.onAddLocation,
    required this.passContext,
  });

  final Function() onCreatedStroy, onAddLocation;
  final Function(BuildContext context) passContext;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoryBloc, StoryState>(
      listener: (context, state) {
        if (state is StoryStateError) {
          BlocProvider.of<ButtonBloc>(context).add(ButtonErrorEvent());
          BlocProvider.of<SnackbarBloc>(context).add(
            SnackBarTriggerEvent(
              message: "Something went wrong",
              color: Colors.red,
            ),
          );
        }

        if (state is StoryStateLoading) {
          BlocProvider.of<ButtonBloc>(context).add(ButtonLoadingEvent());
        }

        if (state is StoryStateCreate) {
          BlocProvider.of<ButtonBloc>(context).add(ButtonRestartEvent());

          BlocProvider.of<AllStoriesBloc>(context).add(RefreshAllStoriesEvent());

          onCreatedStroy();
        }
      },
      builder: (context, state) {
        passContext(context);

        return CreateStoryScaffold(
          onCreate: (photo, description) {
            BlocProvider.of<StoryBloc>(context).add(StoryEventCreate(
              photo: photo,
              description: description,
              latLng: state is StoryStateUpdateLocation ? state.latLng : null,
            ));
          },
          onAddLocation: onAddLocation,
        );
      },
    );
  }
}
