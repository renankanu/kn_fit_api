import 'dart:convert';

class TokenPair {
  TokenPair(this.token, this.refreshToken);

  final String token;
  final String refreshToken;

  Map<String, dynamic> toJson() => {
        'token': token,
        'refreshToken': refreshToken,
      };

  @override
  String toString() => json.encode(toJson());
}
