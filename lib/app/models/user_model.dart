import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends BaseModel {
  final String fullName;
  final String email;
  @JsonKey(toJson: toNull, includeIfNull: false)
  final String password;

  UserModel({
    required this.fullName,
    required this.email,
    required this.password,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  UserModel copyWith({
    int? id,
    String? fullName,
    String? email,
    String? password,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static String? toNull(_) => null;
}
