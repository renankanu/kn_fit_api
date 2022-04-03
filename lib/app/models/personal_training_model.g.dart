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
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  val['fullName'] = instance.fullName;
  val['email'] = instance.email;
  writeNotNull('password', PersonalTrainingModel.toNull(instance.password));
  val['crefType'] = instance.crefType;
  val['crefNumber'] = instance.crefNumber;
  return val;
}
