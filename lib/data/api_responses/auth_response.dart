import 'package:json_annotation/json_annotation.dart';
import 'package:starter/data/model/auth.dart';
import 'package:starter/data/model/user.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  final bool error;
  final String message;
  @JsonKey(name: "loginResult", fromJson: authorizationFromJson, toJson: authorizationtoJson)
  final Authorization authorization;

  AuthResponse({required this.error, required this.message, required this.authorization});

  static Authorization authorizationFromJson(dynamic data) {
    return Authorization(
      user: User(id: data['userId'], name: data['name']),
      token: data['token'],
    );
  }

  static dynamic authorizationtoJson(Authorization data) {
    return data.toJson();
  }

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
