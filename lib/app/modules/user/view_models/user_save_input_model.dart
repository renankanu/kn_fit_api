import 'package:kn_fit_api/app/core/core.dart';
import 'package:kn_fit_api/app/core/helpers/helpers.dart';

class UserSaveInputModel extends RequestMapping {
  late String fullName;
  late String email;
  late String password;

  UserSaveInputModel({
    required this.fullName,
    required this.email,
    required this.password,
  }) : super.empty();

  UserSaveInputModel.requestMapping(String dataRequest) : super(dataRequest);

  @override
  void map() {
    fullName = data['fullName'] ??
        (throw RequiredFieldException(fieldName: 'fullName'));
    email = data['email'] ?? (throw RequiredFieldException(fieldName: 'email'));
    password = data['password'] ??
        (throw RequiredFieldException(fieldName: 'password'));
  }
}
