// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscle_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MuscleGroupModel _$MuscleGroupModelFromJson(Map<String, dynamic> json) =>
    MuscleGroupModel(
      name: json['name'] as String,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$MuscleGroupModelToJson(MuscleGroupModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  return val;
}
