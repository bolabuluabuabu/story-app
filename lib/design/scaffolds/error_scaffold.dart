import 'package:flutter/material.dart';
import 'package:starter/design/widgets/custom_scaffold.dart';

class ErrorSacffold extends StatelessWidget {
  const ErrorSacffold({super.key, this.title, required this.onReload});
  final String? title;
  final Function() onReload;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: title,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Something went wrong, try again.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: onReload,
              child: const Icon(Icons.refresh),
            )
          ],
        ),
      ),
    );
  }
}
