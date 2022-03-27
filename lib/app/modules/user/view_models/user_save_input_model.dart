import 'package:kn_fit_api/app/core/core.dart';
import 'package:kn_fit_api/app/core/helpers/helpers.dart';

class UserSaveInputModel extends RequestMapping {
  late String name;
  late String email;
  late String password;

  UserSaveInputModel(
      {required this.name, required this.email, required this.password})
      : super.empty();

  UserSaveInputModel.requestMapping(String dataRequest) : super(dataRequest);

  @override
  void map() {
    if (!data.containsKey('name')) {
      throw RequiredFieldException(fieldName: 'name');
    }
    name = data['name'];
    email = data['email'];
    password = data['password'];
  }
}
