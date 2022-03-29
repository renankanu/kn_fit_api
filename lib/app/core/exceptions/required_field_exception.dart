class RequiredFieldException implements Exception {
  ///
  /// A fields name that is required.
  ///
  final List<String> keysWithNullValues;
  RequiredFieldException(this.keysWithNullValues);

  @override
  String toString() =>
      'Esses campos contem valores `null` ou vazio: $keysWithNullValues.';
}
