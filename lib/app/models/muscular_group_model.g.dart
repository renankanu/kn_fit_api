// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscular_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MuscularGroupModel _$MuscularGroupModelFromJson(Map<String, dynamic> json) =>
    MuscularGroupModel(
      name: json['name'] as String,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$MuscularGroupModelToJson(MuscularGroupModel instance) {
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
