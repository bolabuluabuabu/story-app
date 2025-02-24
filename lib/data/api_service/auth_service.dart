import 'dart:convert';

import 'package:starter/data/api_responses/auth_response.dart';
import 'package:starter/data/api_service/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:starter/data/model/auth.dart';

class AuthService extends ApiService {
  AuthService() : super(Authorization(user: null, token: null));

  Future<void> register({required String name, required String email, required String password}) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    final decodedResponse = jsonDecode(response.body);

    if (decodedResponse['error'] != null && decodedResponse['error'] == false) {
    } else {
      throw Exception(decodedResponse['message']);
    }
  }

  Future<AuthResponse> login({required String email, required String password}) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      body: {
        'email': email,
        'password': password,
      },
    );

    final decodedResponse = jsonDecode(response.body);

    if (decodedResponse['error'] != null && decodedResponse['error'] == false) {
      return AuthResponse.fromJson(decodedResponse);
    } else {
      throw Exception(decodedResponse['message']);
    }
  }
}
