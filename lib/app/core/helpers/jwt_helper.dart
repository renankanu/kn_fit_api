import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dotenv/dotenv.dart';
import 'package:uuid/uuid.dart';

import '../../models/models.dart';

class JwtHelper {
  JwtHelper._();

  static final String _secret = env['JWT_SECRET']!;

  static String generateJWT(
    int refId, {
    required String email,
    required String fullName,
    required String refType,
    Duration expiry = const Duration(hours: 1),
  }) {
    final jwt = JWT(
      {
        'ref': refId,
        'email': email,
        'fullName': fullName,
        'type': refType,
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

  static TokenPair createTokenPair(
    int userId,
    String email,
    String fullName,
    String refType,
  ) {
    final token = generateJWT(
      userId,
      email: email,
      fullName: fullName,
      refType: refType,
    );
    const refreshTokenExpiry = Duration(seconds: 60);
    final refreshToken = generateJWT(
      userId,
      email: email,
      fullName: fullName,
      refType: refType,
      expiry: refreshTokenExpiry,
    );

    return TokenPair(token: token, refreshToken: refreshToken);
  }
}
