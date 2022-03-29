import 'package:kn_fit_api/app/core/exceptions/required_field_exception.dart';

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
                (entry.value == null || entry.value.trim() == ''),
          )
          .map((entry) => entry.key as String)
          .toList();

      if (nullValuedKeys.isNotEmpty) {
        throw RequiredFieldException(nullValuedKeys);
      }
    }
  }
}
