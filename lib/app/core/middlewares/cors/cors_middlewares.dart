import 'dart:io';

import 'package:shelf/shelf.dart';

import '../base_middleware.dart';

class CorsMiddlewares extends BaseMiddleware {
  final Map<String, String> headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Header':
        '${HttpHeaders.contentTypeHeader}, ${HttpHeaders.authorizationHeader}'
  };
  @override
  Future<Response> execute(Request request) async {
    if (request.method == 'OPTIONS') {
      return Response(HttpStatus.ok, headers: headers);
    }

    final response = await innerHandler(request);

    return response.change(headers: headers);
  }
}
