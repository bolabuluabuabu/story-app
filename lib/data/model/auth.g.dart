// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authorization _$AuthorizationFromJson(Map<String, dynamic> json) => Authorization(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$AuthorizationToJson(Authorization instance) => <String, dynamic>{
      'user': Authorization.userToJson(instance.user),
      'token': instance.token,
    };
