class RequiredFieldException implements Exception {
  ///
  /// A field name that is required.
  ///
  String fieldName;
  RequiredFieldException({
    required this.fieldName,
  });

  @override
  String toString() => 'Campo obrigatório: $fieldName.';
}
