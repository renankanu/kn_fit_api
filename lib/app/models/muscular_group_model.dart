import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'muscular_group_model.g.dart';

@JsonSerializable()
class MuscularGroupModel extends BaseModel {
  final String name;

  MuscularGroupModel({
    required this.name,
  });

  factory MuscularGroupModel.fromJson(Map<String, dynamic> json) =>
      _$MuscularGroupModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MuscularGroupModelToJson(this);
}
