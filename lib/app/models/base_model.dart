import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable()
class BaseModel {
  @JsonKey(includeIfNull: false)
  final int? id;
  @JsonKey(includeIfNull: false)
  final DateTime? createTime;
  @JsonKey(includeIfNull: false)
  final DateTime? updateTime;

  BaseModel({
    this.id,
    this.createTime,
    this.updateTime,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);

  static dynamic toNull(_) => null;
}
