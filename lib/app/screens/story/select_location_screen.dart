import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/bloc/story/story_bloc.dart';
import 'package:starter/design/scaffolds/select_location_scaffold.dart';

class SelectLocationScreen extends StatelessWidget {
  const SelectLocationScreen({
    super.key,
    required this.createStoryContext,
    required this.onUpdatedLocation,
  });
  final BuildContext createStoryContext;
  final Function() onUpdatedLocation;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<StoryBloc>(createStoryContext),
      child: SelectLocationScreenBuilder(
        onUpdatedLocation: onUpdatedLocation,
      ),
    );
  }
}

class SelectLocationScreenBuilder extends StatelessWidget {
  const SelectLocationScreenBuilder({
    super.key,
    required this.onUpdatedLocation,
  });
  final Function() onUpdatedLocation;

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoryBloc, StoryState>(
      listener: (context, state) {
        if (state is StoryStateUpdateLocation) {
          onUpdatedLocation();
        }
      },
      child: SelectLocationScaffold(
        onSelectLocation: (val) {
          BlocProvider.of<StoryBloc>(context).add(
            StoryEventUpdateLocation(
              latLng: val,
            ),
          );
        },
      ),
    );
  }
}
