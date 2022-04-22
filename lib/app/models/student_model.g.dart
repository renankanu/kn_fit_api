// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) => StudentModel(
      avatar: json['avatar'] as String?,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      calledBy: json['called_by'] as String?,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      password: json['password'] as String,
      personalTrainingId: json['personal_training_id'] as int,
      id: json['id'] as int?,
      createTime: json['create_time'] == null
          ? null
          : DateTime.parse(json['create_time'] as String),
      updateTime: json['update_time'] == null
          ? null
          : DateTime.parse(json['update_time'] as String),
    );

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('create_time', instance.createTime?.toIso8601String());
  writeNotNull('update_time', instance.updateTime?.toIso8601String());
  val['avatar'] = instance.avatar;
  val['full_name'] = instance.fullName;
  val['email'] = instance.email;
  val['called_by'] = instance.calledBy;
  val['gender'] = _$GenderEnumMap[instance.gender];
  val['password'] = instance.password;
  val['personal_training_id'] = instance.personalTrainingId;
  return val;
}

const _$GenderEnumMap = {
  Gender.female: 'female',
  Gender.male: 'male',
  Gender.other: 'other',
};
