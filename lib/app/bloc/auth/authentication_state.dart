part of 'package:starter/app/bloc/auth/authentication_bloc.dart';

abstract class AuthenticationState {}

class UninitializedAuthenticationState extends AuthenticationState {}

class AuthenticationStateAuthenticated extends AuthenticationState {
  final Authorization data;

  AuthenticationStateAuthenticated({required this.data});
}

class AuthenticationStateUnauthenticated extends AuthenticationState {}

class AuthenticationStateError extends AuthenticationState {}

class AuthenticationStateLoading extends AuthenticationState {}

class AuthenticationStateRegistered extends AuthenticationState {}
