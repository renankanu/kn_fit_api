enum TokenType { student, personalTraining }

extension TokenTypeExtension on TokenType {
  String? get name {
    switch (this) {
      case TokenType.student:
        return 'student';
      case TokenType.personalTraining:
        return 'personalTraining';
      default:
        return null;
    }
  }
}

class TokenTypeUtils {
  TokenTypeUtils._();

  static TokenType? fromString(String tokenType) {
    switch (tokenType) {
      case 'student':
        return TokenType.student;
      case 'personalTraining':
        return TokenType.personalTraining;
      default:
        return null;
    }
  }
}
