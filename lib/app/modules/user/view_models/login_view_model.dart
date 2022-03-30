import 'package:kn_fit_api/app/core/helpers/helpers.dart';
import 'package:kn_fit_api/app/core/helpers/valid_fields.dart';

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
    email = data['email'];
    password = data['password'];
  }
}
