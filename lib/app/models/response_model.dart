import 'dart:convert';

class ResponseModel {
  ResponseModel({
    required this.status,
    required this.message,
    required this.internalMessage,
    this.data,
  });

  final int status;
  final String message;
  final String internalMessage;
  final dynamic data;

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'internalMessage': internalMessage,
      'data': data,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      status: map['status'] ?? 0,
      message: map['message'] ?? '',
      internalMessage: map['internalMessage'] ?? '',
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source));

  ResponseModel copyWith({
    int? status,
    String? message,
    String? internalMessage,
    dynamic data,
  }) {
    return ResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      internalMessage: internalMessage ?? this.internalMessage,
      data: data ?? this.data,
    );
  }
}
