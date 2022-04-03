import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';

part 'token_pair.g.dart';

@JsonSerializable()
class TokenPair extends BaseModel {
  TokenPair({
    required this.token,
    required this.refreshToken,
  });

  final String token;
  final String refreshToken;

  @override
  Map<String, dynamic> toJson() => _$TokenPairToJson(this);
}
