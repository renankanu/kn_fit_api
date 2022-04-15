import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dotenv/dotenv.dart';
import 'package:shelf/shelf.dart';

import '../../../models/models.dart';
import '../../core.dart';
import '../base_middleware.dart';

class SecurityMiddleware extends BaseMiddleware {
  final ILogger log;
  final skipUrl = <SecuritySkipUrl>[
    SecuritySkipUrl(url: '/student/register', method: 'POST'),
    SecuritySkipUrl(url: '/personal-training/register', method: 'POST'),
    SecuritySkipUrl(url: '/student/login', method: 'POST'),
    SecuritySkipUrl(url: '/personal-training/login', method: 'POST'),
    SecuritySkipUrl(url: '/health', method: 'GET'),
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

      final authorizationHeader = request.headers['Authorization'];
      String? authorizationToken;
      int? userId;
      String? tokenType;

      if (authorizationHeader == null) {
        return responseErrorJWT(JWTError('Authorization header is required'));
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
    } on JWTInvalidError catch (error) {
      return responseErrorJWT<JWTInvalidError>(error);
    } on JWTExpiredError catch (error) {
      return responseErrorJWT<JWTExpiredError>(error);
    } on JWTNotActiveError catch (error) {
      return responseErrorJWT<JWTNotActiveError>(error);
    } on JWTUndefinedError catch (error) {
      return responseErrorJWT<JWTUndefinedError>(error);
    } catch (error) {
      return responseErrorJWT<Object>(error);
    }
  }

  Response responseErrorJWT<T>(T error) {
    return ResponseHelper.baseResponse(
      403,
      responseModel: ResponseModel(
        data: null,
        message: error.toString(),
      ),
    );
  }
}
