import 'dart:convert';

import 'package:crypto/crypto.dart';

class CryptoHelper {
  CryptoHelper._();

  static String generatedSha256Hash(String valueToCrypto) {
    final bytes = utf8.encode(valueToCrypto);
    return sha256.convert(bytes).toString();
  }
}
