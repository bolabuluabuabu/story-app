import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:starter/design/widgets/custom_scaffold.dart';

class LoadingScaffold extends StatelessWidget {
  const LoadingScaffold({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: title,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Loading',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(width: 20),
            LoadingAnimationWidget.waveDots(color: Colors.black, size: 40)
          ],
        ),
      ),
    );
  }
}
