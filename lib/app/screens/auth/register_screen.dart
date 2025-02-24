import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/bloc/auth/authentication_bloc.dart';
import 'package:starter/design/bloc/button/design_bloc.dart';
import 'package:starter/design/scaffolds/authentication_scaffold.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key, required this.onRegistered});
  final Function() onRegistered;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
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

        if (state is AuthenticationStateRegistered) {
          BlocProvider.of<ButtonBloc>(context).add(ButtonRestartEvent());

          onRegistered();
        }
      },
      builder: (context, state) {
        return AuthenticationScaffold(
          isRegister: true,
          onTapButton: (email, password, name) {
            if (email.isNotEmpty && password.isNotEmpty && name != null && name.isNotEmpty) {
              BlocProvider.of<AuthenticationBloc>(context).add(
                RegisterEvent(name: name, email: email, password: password),
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
