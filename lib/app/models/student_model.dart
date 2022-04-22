import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../core/core.dart';
import 'models.dart';

part 'student_model.g.dart';

@JsonSerializable()
class StudentModel extends BaseModel {
  final String? avatar;
  final String fullName;
  final String email;
  final String? calledBy;
  final Gender gender;
  @JsonKey(toJson: null, includeIfNull: false)
  final String password;
  final int personalTrainingId;

  StudentModel({
    this.avatar,
    required this.fullName,
    required this.email,
    this.calledBy,
    required this.gender,
    required this.password,
    required this.personalTrainingId,
    int? id,
    DateTime? createTime,
    DateTime? updateTime,
  }) : super(id: id, createTime: createTime, updateTime: updateTime);

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StudentModelToJson(this);

  factory StudentModel.requestMapping(String body) {
    final json = jsonDecode(body) as Map<String, dynamic>;
    ValidFields.nullChecker(
      json,
      requiredKeys: [
        'fullName',
        'email',
        'password',
        'gender',
        'personalTrainingId',
      ],
      nonNullKeys: [
        'fullName',
        'email',
        'password',
        'gender',
        'personalTrainingId',
      ],
    );
    return StudentModel.fromJson(json);
  }

  StudentModel copyWith({
    String? avatar,
    String? fullName,
    String? email,
    String? calledBy,
    Gender? gender,
    String? password,
    int? personalTrainingId,
  }) {
    return StudentModel(
      avatar: avatar ?? this.avatar,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      calledBy: calledBy ?? this.calledBy,
      gender: gender ?? this.gender,
      password: password ?? this.password,
      personalTrainingId: personalTrainingId ?? this.personalTrainingId,
    );
  }
}
