import '../../../core/helpers/helpers.dart';

class StudentSaveInputModel extends RequestMapping {
  late String fullName;
  late String email;
  late String password;

  StudentSaveInputModel({
    required this.fullName,
    required this.email,
    required this.password,
  }) : super.empty();

  StudentSaveInputModel.requestMapping(String dataRequest) : super(dataRequest);

  @override
  void map() {
    ValidFields.nullChecker(
      data,
      requiredKeys: ['fullName', 'email', 'password'],
      nonNullKeys: ['fullName', 'email', 'password'],
    );
    fullName = data['fullName'] as String;
    email = data['email'] as String;
    password = data['password'] as String;
  }
}
