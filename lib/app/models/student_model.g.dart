// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) => StudentModel(
      avatar: json['avatar'] as String?,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      calledBy: json['calledBy'] as String?,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      password: json['password'] as String,
      personalTrainingId: json['personalTrainingId'] as int,
      id: json['id'] as int?,
      createTime: json['createTime'] == null
          ? null
          : DateTime.parse(json['createTime'] as String),
      updateTime: json['updateTime'] == null
          ? null
          : DateTime.parse(json['updateTime'] as String),
    );

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('createTime', instance.createTime?.toIso8601String());
  writeNotNull('updateTime', instance.updateTime?.toIso8601String());
  val['avatar'] = instance.avatar;
  val['fullName'] = instance.fullName;
  val['email'] = instance.email;
  val['calledBy'] = instance.calledBy;
  val['gender'] = _$GenderEnumMap[instance.gender]!;
  writeNotNull('password', BaseModel.toNull(instance.password));
  val['personalTrainingId'] = instance.personalTrainingId;
  return val;
}

const _$GenderEnumMap = {
  Gender.female: 1,
  Gender.male: 2,
  Gender.other: 3,
};
