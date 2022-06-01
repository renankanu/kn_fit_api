import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../core/core.dart';
import 'base_model.dart';

part 'personal_training_model.g.dart';

@JsonSerializable()
class PersonalTrainingModel extends BaseModel {
  final String? avatar;
  final String fullName;
  final String email;
  @JsonKey(toJson: BaseModel.toNull, includeIfNull: false)
  final String password;
  final String crefType;
  final int crefNumber;

  PersonalTrainingModel({
    this.avatar,
    required this.fullName,
    required this.email,
    required this.password,
    required this.crefType,
    required this.crefNumber,
    int? id,
    DateTime? createTime,
    DateTime? updateTime,
  }) : super(id: id, createTime: createTime, updateTime: updateTime);

  factory PersonalTrainingModel.fromJson(Map<String, dynamic> json) =>
      _$PersonalTrainingModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PersonalTrainingModelToJson(this);

  factory PersonalTrainingModel.fromDataBase(
    Map<String, dynamic> dataBaseFields,
  ) {
    return PersonalTrainingModel(
      id: dataBaseFields['id'] as int,
      avatar: dataBaseFields['avatar'] as String?,
      fullName: dataBaseFields['full_name'] as String,
      email: dataBaseFields['email'] as String,
      password: dataBaseFields['password'] as String,
      crefType: dataBaseFields['cref_type'] as String,
      crefNumber: dataBaseFields['cref_number'] as int,
      createTime: dataBaseFields['create_time'],
      updateTime: dataBaseFields['update_time'],
    );
  }

  factory PersonalTrainingModel.requestMapping(String body) {
    final json = jsonDecode(body) as Map<String, dynamic>;
    ValidFields.nullChecker(
      json,
      requiredKeys: [
        'fullName',
        'email',
        'password',
        'crefType',
        'crefNumber',
      ],
      nonNullKeys: [
        'fullName',
        'email',
        'password',
        'crefType',
        'crefNumber',
      ],
    );
    return PersonalTrainingModel.fromJson(json);
  }
}
