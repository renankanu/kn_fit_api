import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../core/core.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  String email;
  String password;

  LoginModel({required this.email, required this.password});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  factory LoginModel.requestMapping(String body) {
    final json = jsonDecode(body) as Map<String, dynamic>;
    ValidFields.nullChecker(
      json,
      requiredKeys: ['email', 'password'],
      nonNullKeys: ['email', 'password'],
    );
    return LoginModel.fromJson(json);
  }
}
