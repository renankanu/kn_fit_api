import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable()
class BaseModel {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BaseModel({
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}
