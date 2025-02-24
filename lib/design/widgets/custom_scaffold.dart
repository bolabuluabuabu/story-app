import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/design/bloc/button/snackbar_bloc.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    required this.title,
    this.appBarAction,
    this.floatingActionButton,
  });
  final Widget body;
  final String? title;
  final Widget? appBarAction, floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SnackbarBloc, SnackBarState>(
      listener: (context, state) {
        if (state is SnackBarTriggerState) {
          final ScaffoldMessengerState scaffoldMessengerState = ScaffoldMessenger.of(context);

          scaffoldMessengerState.showSnackBar(
            SnackBar(
              backgroundColor: state.color,
              showCloseIcon: true,
              content: Text(
                state.message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: title == null
            ? null
            : AppBar(
                backgroundColor: Colors.amber,
                title: Text(title!),
                centerTitle: false,
                actions: [
                  if (appBarAction != null) appBarAction!,
                ],
              ),
        resizeToAvoidBottomInset: true,
        body: body,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
