import 'package:flutter/material.dart';
import 'package:starter/data/model/story.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({super.key, required this.story, required this.onTap});
  final Story story;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              height: 200,
              width: 200,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.network(
                story.photoUrl,
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Created by: ${story.name}"),
                  Text("Description: ${story.description}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
