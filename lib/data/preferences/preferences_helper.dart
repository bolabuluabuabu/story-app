import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/data/model/user.dart';

class PreferencesHelper {
  final Future<SharedPreferences> _sharedPreferences;

  PreferencesHelper(this._sharedPreferences);

  String get tokenException => "Token does not exist";
  String get userException => "User does not exist";

  final _userKey = "user";
  final _tokenKey = "token";

  Future<String> getToken() async {
    final preferences = await _sharedPreferences;
    final token = preferences.get(_tokenKey);

    if (token == null || token is! String || token.isEmpty) {
      throw Exception(tokenException);
    }

    return token.toString();
  }

  Future<void> setToken(String token) async {
    final preferences = await _sharedPreferences;

    await preferences.setString(_tokenKey, token);
  }

  Future<User> getUser() async {
    final preferences = await _sharedPreferences;
    final user = preferences.get(_userKey);

    if (user == null || user is! String || user.isEmpty) {
      throw Exception(userException);
    }

    return User.fromJson(jsonDecode(user));
  }

  Future<void> setUser(User user) async {
    final preferences = await _sharedPreferences;

    await preferences.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<void> clearData() async {
    final preferences = await _sharedPreferences;

    await preferences.remove(_tokenKey);
    await preferences.remove(_userKey);
  }
}
