import 'package:kn_fit_api/app/core/helpers/helpers.dart';

class UserSaveInputModel extends RequestMapping {
  late String email;
  late String password;
  int? supplierId;

  UserSaveInputModel(
      {required this.email, required this.password, this.supplierId})
      : super.empty();

  UserSaveInputModel.requestMapping(String dataRequest) : super(dataRequest);

  @override
  void map() {
    email = data['email'];
    password = data['password'];
  }
}
