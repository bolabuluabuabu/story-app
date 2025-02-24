part of 'package:starter/app/bloc/auth/authentication_bloc.dart';

abstract class AuthenticationEvent {}

class CheckEvent extends AuthenticationEvent {}

class RegisterEvent extends AuthenticationEvent {
  final String name;
  final String email;
  final String password;

  RegisterEvent({required this.name, required this.email, required this.password});
}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class LogoutEvent extends AuthenticationEvent {}
