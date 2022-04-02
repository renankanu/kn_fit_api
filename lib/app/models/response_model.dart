import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel {
  ResponseModel({
    required this.message,
    this.data,
  });

  final String message;
  final BaseModel? data;

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);

  @override
  String toString() => json.encode(toJson());
}
