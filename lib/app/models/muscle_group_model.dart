import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../core/core.dart';
import 'models.dart';

part 'muscle_group_model.g.dart';

@JsonSerializable()
class MuscleGroupModel extends BaseModel {
  final String name;

  MuscleGroupModel({
    required this.name,
    int? id,
  }) : super(id: id);

  factory MuscleGroupModel.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MuscleGroupModelToJson(this);

  factory MuscleGroupModel.requestMapping(String body) {
    final json = jsonDecode(body) as Map<String, dynamic>;
    ValidFields.nullChecker(
      json,
      requiredKeys: ['name'],
      nonNullKeys: ['name'],
    );
    return MuscleGroupModel.fromJson(json);
  }
}
