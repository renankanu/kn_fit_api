class RequiredFieldException implements Exception {
  String fieldName;
  RequiredFieldException({
    required this.fieldName,
  });

  @override
  String toString() => fieldName;
}
