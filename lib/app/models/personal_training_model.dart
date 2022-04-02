import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';

part 'personal_training_model.g.dart';

@JsonSerializable()
class PersonalTrainingModel extends BaseModel {
  final String fullName;
  final String email;
  @JsonKey(toJson: toNull, includeIfNull: false)
  final String password;
  final String crefType;
  final String crefNumber;

  PersonalTrainingModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.crefType,
    required this.crefNumber,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  factory PersonalTrainingModel.fromJson(Map<String, dynamic> json) =>
      _$PersonalTrainingModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PersonalTrainingModelToJson(this);

  static String? toNull(_) => null;
}
