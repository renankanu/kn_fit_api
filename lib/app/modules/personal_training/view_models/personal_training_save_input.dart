import '../../../core/core.dart';

class PersonalTrainingSaveInput extends RequestMapping {
  late String fullName;
  late String email;
  late String password;
  late String crefType;
  late String crefNumber;

  PersonalTrainingSaveInput({
    required this.fullName,
    required this.email,
    required this.password,
    required this.crefType,
    required this.crefNumber,
  }) : super.empty();

  PersonalTrainingSaveInput.requestMapping(String dataRequest)
      : super(dataRequest);

  @override
  void map() {
    ValidFields.nullChecker(
      data,
      requiredKeys: [
        'fullName',
        'email',
        'password',
        'crefType',
        'crefNumber',
      ],
      nonNullKeys: [
        'fullName',
        'email',
        'password',
        'crefType',
        'crefNumber',
      ],
    );
    fullName = data['fullName'] as String;
    email = data['email'] as String;
    password = data['password'] as String;
    crefType = data['crefType'] as String;
    crefNumber = data['crefNumber'] as String;
  }
}
