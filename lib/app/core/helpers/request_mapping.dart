import 'dart:convert';

abstract class RequestMapping {
  final Map<String, dynamic> data;

  RequestMapping(String dataRequest)
      : data = jsonDecode(dataRequest) as Map<String, dynamic> {
    map();
  }

  RequestMapping.empty() : data = {};

  void map();
}
