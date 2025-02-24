import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/bloc/auth/authentication_bloc.dart';
import 'package:starter/design/scaffolds/loading_scaffold.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key, required this.isAuthenticated});
  final Function(bool val) isAuthenticated;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationStateAuthenticated) {
          isAuthenticated(true);
        }

        if (state is AuthenticationStateUnauthenticated) {
          isAuthenticated(false);
        }
      },
      builder: (context, state) {
        return const LoadingScaffold();
      },
    );
  }
}
