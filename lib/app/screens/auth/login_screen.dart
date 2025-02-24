import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/bloc/auth/authentication_bloc.dart';
import 'package:starter/design/bloc/button/design_bloc.dart';
import 'package:starter/design/scaffolds/authentication_scaffold.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.onLoggedIn, required this.onRegister});

  final Function() onRegister, onLoggedIn;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationStateLoading) {
          BlocProvider.of<ButtonBloc>(context).add(ButtonLoadingEvent());
        }

        if (state is AuthenticationStateError) {
          BlocProvider.of<ButtonBloc>(context).add(ButtonErrorEvent());
          BlocProvider.of<SnackbarBloc>(context).add(
            SnackBarTriggerEvent(
              message: "Something went wrong",
              color: Colors.red,
            ),
          );
        }

        if (state is AuthenticationStateAuthenticated) {
          BlocProvider.of<ButtonBloc>(context).add(ButtonRestartEvent());

          onLoggedIn();
        }
      },
      builder: (context, state) {
        return AuthenticationScaffold(
          onRegister: onRegister,
          onTapButton: (email, password, name) {
            if (email.isNotEmpty && password.isNotEmpty) {
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoginEvent(email: email, password: password),
              );
            } else {
              BlocProvider.of<SnackbarBloc>(context).add(
                SnackBarTriggerEvent(
                  message: "All field can not be empty",
                  color: Colors.red,
                ),
              );
            }
          },
        );
      },
    );
  }
}
