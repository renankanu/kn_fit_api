// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) => StudentModel(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      personalTrainingId: json['personalTrainingId'] as int,
      id: json['id'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) {
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

  writeNotNull('password', StudentModel.toNull(instance.password));
  val['personalTrainingId'] = instance.personalTrainingId;
  return val;
}
