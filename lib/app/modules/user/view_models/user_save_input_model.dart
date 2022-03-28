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
    fullName = data['fullName'];
    email = data['email'];
    password = data['password'];
  }
}
