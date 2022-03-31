import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dotenv/dotenv.dart';
import 'package:uuid/uuid.dart';

class JwtHelper {
  JwtHelper._();

  static final String _secret = env['JWT_SECRET']!;

  static String generateJWT(
    String userId,
  ) {
    final jwt = JWT(
      {
        'ref': userId,
        'iat': DateTime.now().millisecondsSinceEpoch,
      },
      issuer: 'https://www.renankanu.com.br',
      jwtId: Uuid().v4(),
    );

    final token = jwt.sign(
      SecretKey(_secret),
      expiresIn: Duration(hours: 1),
    );
    return token;
  }
}
