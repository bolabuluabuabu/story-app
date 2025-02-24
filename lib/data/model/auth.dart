import 'package:json_annotation/json_annotation.dart';
import 'package:starter/data/model/user.dart';

part 'auth.g.dart';

@JsonSerializable()
class Authorization {
  @JsonKey(fromJson: User.fromJson, toJson: userToJson)
  final User? user;
  final String? token;

  Authorization({required this.user, required this.token});

  get isAuthorized => user != null && token != null && token!.isNotEmpty;

  static dynamic userToJson(User? data) {
    if (data != null && data.id.isNotEmpty && data.name.isNotEmpty) {
      return {'id': data.id, 'name': data.name};
    }

    return null;
  }

  factory Authorization.fromJson(Map<String, dynamic> json) => _$AuthorizationFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizationToJson(this);
}
