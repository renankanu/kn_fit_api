import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'student_model.g.dart';

@JsonSerializable()
class StudentModel extends BaseModel {
  final String fullName;
  final String email;
  @JsonKey(toJson: toNull, includeIfNull: false)
  final String password;

  StudentModel({
    required this.fullName,
    required this.email,
    required this.password,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  StudentModel copyWith({
    int? id,
    String? fullName,
    String? email,
    String? password,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StudentModelToJson(this);

  static String? toNull(_) => null;
}
