import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dotenv/dotenv.dart';
import 'package:shelf/shelf.dart' hide Middleware;

import '../../core.dart';
import '../middleware.dart';
import 'security_skip_url.dart';

class SecurityMiddleware extends Middleware {
  final ILogger log;
  final skipUrl = <SecuritySkipUrl>[
    SecuritySkipUrl(url: '/user/register', method: 'POST'),
    SecuritySkipUrl(url: '/auth/', method: 'POST'),
    SecuritySkipUrl(url: '/health', method: 'GET'),
  ];

  SecurityMiddleware(this.log);

  @override
  Future<Response> execute(Request request) async {
    try {
      if (skipUrl.contains(SecuritySkipUrl(
          url: '/${request.url.path}', method: request.method))) {
        return innerHandler(request);
      }

      final authHeader = request.headers['Authorization'];

      if (authHeader == null || authHeader.isEmpty) {
        throw JWTError('Token não informado.');
      }

      final authHeaderContent = authHeader.split(' ');

      if (authHeaderContent[0] != 'Bearer') {
        throw JWTError('Token inválido.');
      }

      final authorizationToken = authHeaderContent[1];
      final claims =
          JWT.verify(authorizationToken, SecretKey(env['JWT_SECRET']!));

      // if (request.url.path != 'auth/refresh') {
      //   claims.validate();
      // }

      final claimsMap = claims.payload();

      final userId = claimsMap['sub'];
      final supplierId = claimsMap['supplier'];

      if (userId == null) {
        throw JWTError('Usuário não encontrado.');
      }

      final securityHeaders = {
        'user': userId,
        'access_token': authorizationToken,
        'supplier': supplierId != null ? '$supplierId' : null
      };

      return innerHandler(request.change(headers: securityHeaders));
    } on JWTError catch (e, s) {
      log.error('Erro ao validar token JWT', e, s);
      return Response.forbidden(jsonEncode({}));
    } catch (e, s) {
      log.error('Internal Server Error', e, s);
      return Response.forbidden(jsonEncode({}));
    }
  }
}
