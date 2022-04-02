// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_training_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalTrainingModel _$PersonalTrainingModelFromJson(
        Map<String, dynamic> json) =>
    PersonalTrainingModel(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      crefType: json['crefType'] as String,
      crefNumber: json['crefNumber'] as String,
      id: json['id'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PersonalTrainingModelToJson(
    PersonalTrainingModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'createdAt': instance.createdAt?.toIso8601String(),
    'updatedAt': instance.updatedAt?.toIso8601String(),
    'fullName': instance.fullName,
    'email': instance.email,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('password', PersonalTrainingModel.toNull(instance.password));
  val['crefType'] = instance.crefType;
  val['crefNumber'] = instance.crefNumber;
  return val;
}
