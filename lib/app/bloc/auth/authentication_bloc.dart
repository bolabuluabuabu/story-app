import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/data/api_service/auth_service.dart';
import 'package:starter/data/model/auth.dart';
import 'package:starter/data/model/user.dart';
import 'package:starter/data/preferences/preferences_helper.dart';

part 'package:starter/app/bloc/auth/authentication_state.dart';
part 'package:starter/app/bloc/auth/authentication_event.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final PreferencesHelper _preferencesHelper;
  final AuthService _authService;

  Authorization? auth;

  AuthenticationBloc(this._preferencesHelper, this._authService) : super(UninitializedAuthenticationState()) {
    on<CheckEvent>(_onCheckEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<LoginEvent>(_onLoginEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  _onCheckEvent(CheckEvent event, Emitter<AuthenticationState> emit) async {
    try {
      final token = await _preferencesHelper.getToken();
      final user = await _preferencesHelper.getUser();

      auth = Authorization(user: user, token: token);

      emit(AuthenticationStateAuthenticated(data: auth!));
    } catch (e) {
      emit(AuthenticationStateUnauthenticated());
    }
  }

  _onRegisterEvent(RegisterEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(AuthenticationStateLoading());

      await _authService.register(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      emit(AuthenticationStateRegistered());
    } catch (e) {
      emit(AuthenticationStateError());
    }
  }

  _onLoginEvent(LoginEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(AuthenticationStateLoading());

      final res = await _authService.login(
        email: event.email,
        password: event.password,
      );

      if (res.authorization.token == null || res.authorization.user == null) {
        throw Exception(res.message);
      }

      final token = res.authorization.token!;
      final user = User(
        id: res.authorization.user!.id,
        name: res.authorization.user!.name,
      );

      await _preferencesHelper.setToken(token);
      await _preferencesHelper.setUser(user);

      auth = Authorization(user: user, token: token);

      emit(AuthenticationStateAuthenticated(data: auth!));
    } catch (e) {
      log(e.toString());
      emit(AuthenticationStateError());
    }
  }

  _onLogoutEvent(LogoutEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(AuthenticationStateLoading());

      await _preferencesHelper.clearData();

      emit(AuthenticationStateUnauthenticated());
    } catch (e) {
      emit(AuthenticationStateError());
    }
  }
}
