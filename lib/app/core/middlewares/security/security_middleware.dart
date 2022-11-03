import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dotenv/dotenv.dart';
import 'package:shelf/shelf.dart';

import '../../../models/models.dart';
import '../../core.dart';
import '../base_middleware.dart';

class SecurityMiddleware extends BaseMiddleware {
  final ILogger log;
  final skipUrl = <SecuritySkipUrl>[
    SecuritySkipUrl(url: '/student', method: 'POST'),
    SecuritySkipUrl(url: '/personal-training', method: 'POST'),
    SecuritySkipUrl(url: '/student/login', method: 'POST'),
    SecuritySkipUrl(url: '/personal-training/login', method: 'POST'),
    SecuritySkipUrl(url: '/health', method: 'GET'),
    SecuritySkipUrl(url: '/documentation', method: 'GET'),
  ];

  SecurityMiddleware(this.log);

  @override
  Future<Response> execute(Request request) async {
    try {
      final isSkipUrl = skipUrl.contains(
        SecuritySkipUrl(url: '/${request.url.path}', method: request.method),
      );
      final regexImagePath = RegExp(r'^[0-9]{13}.(gif|jpe?g|png)+$');
      final isImagePath =
          regexImagePath.hasMatch(request.url.path.split('/').last);
      if (isSkipUrl || isImagePath) {
        return innerHandler(request);
      }

      final authorizationHeader = request.headers['Authorization'];
      String? authorizationToken;
      int? userId;
      String? tokenType;

      if (authorizationHeader == null) {
        return responseErrorJWT('Header de Autorização é obrigatório');
      }

      if (authorizationHeader.startsWith('Bearer ')) {
        final token = authorizationHeader.substring(7);
        final claims = JWT.verify(token, SecretKey(env['JWT_SECRET']!));
        final claimsMap = claims.payload as Map<String, dynamic>;
        userId = claimsMap['ref'] as int;
        tokenType = claimsMap['referringTo'] as String;
      }
      return innerHandler(
        request.change(
          headers: {
            'user': userId.toString(),
            'referring_to': tokenType.toString(),
            'access_token': authorizationToken,
          },
        ),
      );
    } on JWTInvalidError {
      return responseErrorJWT<JWTInvalidError>('Token inválido');
    } on JWTExpiredError {
      return responseErrorJWT<JWTExpiredError>('Token expirado');
    } on JWTNotActiveError {
      return responseErrorJWT<JWTNotActiveError>('Token não ativo');
    } on JWTUndefinedError catch (e) {
      if (e.error is JWTExpiredError) {
        return responseErrorJWT<JWTUndefinedError>('Token expirado');
      }
      return responseErrorJWT<JWTUndefinedError>('Token não definido');
    } catch (error) {
      return responseErrorJWT<Object>('Token erro desconhecido');
    }
  }

  Response responseErrorJWT<T>(
    String errorMessage,
  ) {
    return ResponseHelper.baseResponse(
      403,
      responseModel: ResponseModel(
        data: null,
        message: errorMessage,
      ),
    );
  }
}
