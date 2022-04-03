import '../exceptions/required_field_exception.dart';

class ValidFields {
  ValidFields._();

  static void nullChecker(
    Map map, {
    List<String>? requiredKeys,
    List<String>? nonNullKeys,
  }) {
    if (requiredKeys != null) {
      final missingKeys =
          requiredKeys.where((k) => !map.keys.contains(k)).toList();
      if (missingKeys.isNotEmpty) {
        throw RequiredFieldException(missingKeys);
      }
    }

    if (nonNullKeys != null) {
      final nullValuedKeys = map.entries
          .where(
            (entry) =>
                nonNullKeys.contains(entry.key) &&
                (entry.value == null || _checkRequiredByType(entry)),
          )
          .map((entry) => entry.key as String)
          .toList();

      if (nullValuedKeys.isNotEmpty) {
        throw RequiredFieldException(nullValuedKeys);
      }
    }
  }

  static bool _checkRequiredByType(MapEntry<dynamic, dynamic> entry) {
    if (entry.value is String) {
      return entry.value == '';
    }

    if (entry.value is int) {
      return entry.value == 0;
    }

    if (entry.value is double) {
      return entry.value == 0.0;
    }

    if (entry.value is bool) {
      return entry.value == false;
    }

    return false;
  }
}
