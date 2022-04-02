import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dotenv/dotenv.dart';
import 'package:uuid/uuid.dart';

import '../../models/models.dart';

class JwtHelper {
  JwtHelper._();

  static final String _secret = env['JWT_SECRET']!;

  static String generateJWT(
    String userId, {
    Duration expiry = const Duration(hours: 1),
  }) {
    final jwt = JWT(
      {
        'ref': userId,
        'iat': DateTime.now().millisecondsSinceEpoch,
      },
      issuer: 'https://www.renankanu.com.br',
      jwtId: const Uuid().v4(),
    );

    final token = jwt.sign(
      SecretKey(_secret),
      expiresIn: expiry,
    );
    return token;
  }

  static TokenPair createTokenPair(String userId) {
    final token = generateJWT(userId);

    const refreshTokenExpiry = Duration(seconds: 60);
    final refreshToken = generateJWT(
      userId,
      expiry: refreshTokenExpiry,
    );

    return TokenPair(token, refreshToken);
  }
}
