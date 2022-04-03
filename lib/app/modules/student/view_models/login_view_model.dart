import '../../../core/helpers/helpers.dart';

class LoginViewModel extends RequestMapping {
  late String email;
  late String password;

  LoginViewModel(String dataRequest) : super(dataRequest);

  @override
  void map() {
    ValidFields.nullChecker(
      data,
      requiredKeys: ['email', 'password'],
      nonNullKeys: ['email', 'password'],
    );
    email = data['email'] as String;
    password = data['password'] as String;
  }
}
