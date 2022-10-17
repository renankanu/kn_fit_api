import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../core/core.dart';
import 'models.dart';

part 'muscular_group_model.g.dart';

@JsonSerializable()
class MuscularGroupModel extends BaseModel {
  final String name;

  MuscularGroupModel({
    required this.name,
    int? id,
  }) : super(id: id);

  factory MuscularGroupModel.fromJson(Map<String, dynamic> json) =>
      _$MuscularGroupModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MuscularGroupModelToJson(this);

  factory MuscularGroupModel.requestMapping(String body) {
    final json = jsonDecode(body) as Map<String, dynamic>;
    ValidFields.nullChecker(
      json,
      requiredKeys: ['name'],
      nonNullKeys: ['name'],
    );
    return MuscularGroupModel.fromJson(json);
  }
}
