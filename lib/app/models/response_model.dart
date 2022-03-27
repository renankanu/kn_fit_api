import 'dart:convert';

import 'package:kn_fit_api/app/models/base_model.dart';

class ResponseModel {
  ResponseModel({
    required this.message,
    this.data,
  });

  final String message;
  final BaseModel? data;

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      message: map['message'] ?? '',
      data: map['data'] != null ? BaseModel.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source));
}
