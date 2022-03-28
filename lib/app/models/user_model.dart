import 'package:json_annotation/json_annotation.dart';
import 'package:kn_fit_api/app/models/models.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends BaseModel {
  final String fullName;
  final String email;
  final String password;

  UserModel({
    required this.fullName,
    required this.email,
    required this.password,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
