import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../core/helpers/helpers.dart';
import 'base_model.dart';

part 'exercise_model.g.dart';

@JsonSerializable()
class ExerciseModel extends BaseModel {
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? videoUrl;

  ExerciseModel({
    this.name,
    this.description,
    this.imageUrl,
    this.videoUrl,
    int? id,
    DateTime? createTime,
    DateTime? updateTime,
  }) : super(id: id, createTime: createTime, updateTime: updateTime);

  ExerciseModel copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    String? videoUrl,
    DateTime? createTime,
    DateTime? updateTime,
  }) {
    return ExerciseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }

  factory ExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExerciseModelToJson(this);

  factory ExerciseModel.requestMapping(String body) {
    final json = jsonDecode(body) as Map<String, dynamic>;
    ValidFields.nullChecker(
      json,
      requiredKeys: [
        'name',
        'description',
        'imageUrl',
        'videoUrl',
      ],
      nonNullKeys: [
        'name',
        'description',
        'imageUrl',
        'videoUrl',
      ],
    );
    return ExerciseModel.fromJson(json);
  }
}
