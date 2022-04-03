import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dotenv/dotenv.dart';
import 'package:shelf/shelf.dart';

import '../../../models/response_model.dart';
import '../../core.dart';
import '../base_middleware.dart';

class SecurityMiddleware extends BaseMiddleware {
  final ILogger log;
  final skipUrl = <SecuritySkipUrl>[
    SecuritySkipUrl(url: '/student/register', method: 'POST'),
    SecuritySkipUrl(url: '/user/login', method: 'POST'),
    SecuritySkipUrl(url: '/health', method: 'GET'),
    SecuritySkipUrl(url: '/personal-training/register', method: 'POST'),
  ];

  SecurityMiddleware(this.log);

  @override
  Future<Response> execute(Request request) async {
    try {
      if (skipUrl.contains(
        SecuritySkipUrl(url: '/${request.url.path}', method: request.method),
      )) {
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

      final claimsMap = claims.payload as Map<String, dynamic>;

      final userId = claimsMap['ref'];

      if (userId == null) {
        throw JWTError('Usuário não encontrado.');
      }

      final securityHeaders = {
        'user': userId,
        'access_token': authorizationToken,
      };

      return innerHandler(request.change(headers: securityHeaders));
    } on JWTUndefinedError catch (_) {
      return ResponseHelper.baseResponse(
        401,
        responseModel: ResponseModel(
          data: null,
          message: 'Token inválido.',
        ),
      );
    } on JWTError catch (e, _) {
      return ResponseHelper.baseResponse(
        403,
        responseModel: ResponseModel(
          data: null,
          message: e.toString(),
        ),
      );
    } catch (e, _) {
      return ResponseHelper.baseResponse(
        403,
        responseModel: ResponseModel(
          data: null,
          message: e.toString(),
        ),
      );
    }
  }
}
