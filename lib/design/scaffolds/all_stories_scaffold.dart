import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:starter/data/model/story.dart';
import 'package:starter/design/widgets/custom_scaffold.dart';
import 'package:starter/design/widgets/story_item.dart';

class AllStoriesScaffold extends StatefulWidget {
  const AllStoriesScaffold({
    super.key,
    required this.stories,
    required this.onLogOut,
    required this.onAddButton,
    required this.onTapStory,
    required this.onScrollMore,
    required this.isLoadingMore,
    required this.isfetchedAll,
  });
  final List<Story> stories;
  final Function() onLogOut, onAddButton;
  final Function(Story s) onTapStory;
  final Function() onScrollMore;
  final bool isLoadingMore, isfetchedAll;

  @override
  State<AllStoriesScaffold> createState() => _AllStoriesScaffoldState();
}

class _AllStoriesScaffoldState extends State<AllStoriesScaffold> {
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.offset >= scrollController.position.maxScrollExtent) {
        widget.onScrollMore();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "All Stories",
      appBarAction: InkWell(
        onTap: widget.onLogOut,
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Text('Log Out'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onAddButton,
        child: const Icon(Icons.add),
      ),
      body: widget.stories.isEmpty
          ? Center(
              child: Text("There's no story for now"),
            )
          : Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: widget.stories.length + (widget.isfetchedAll ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == widget.stories.length) {
                        return Center(child: Text("Semua story berhasil dimuat!"));
                      }

                      return StoryItem(
                        story: widget.stories[index],
                        onTap: () {
                          widget.onTapStory(widget.stories[index]);
                        },
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: widget.isLoadingMore,
                  child: SafeArea(
                    child: LoadingAnimationWidget.waveDots(
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
