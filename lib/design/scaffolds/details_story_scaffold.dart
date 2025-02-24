import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:starter/data/model/story.dart';
import 'package:starter/design/widgets/custom_scaffold.dart';
import 'package:starter/design/widgets/story_detail_location.dart';

class DetailsStoryScaffold extends StatelessWidget {
  const DetailsStoryScaffold({super.key, required this.story});
  final Story story;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Story Details",
      body: ListView(
        physics: ClampingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          Center(child: Image.network(story.photoUrl)),
          const SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Created by: ${story.name}"),
              Text("Description: ${story.description}"),
              Text(
                DateFormat("yyyy-MM-dd HH:mm:ss").format(story.createdAt),
              ),
              if (story.lat != null && story.lon != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text("Location:"),
                    SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: StoryDetailLocation(
                        id: story.id,
                        latLng: LatLng(story.lat!, story.lon!),
                      ),
                    ),
                  ],
                )
            ],
          )
        ],
      ),
    );
  }
}
