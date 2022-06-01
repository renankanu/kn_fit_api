import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel {
  ResponseModel({
    required this.message,
    this.data,
  });

  final String message;
  final dynamic data;

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);

  @override
  String toString() => json.encode(toJson());
}
