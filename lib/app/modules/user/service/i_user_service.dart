import 'package:kn_fit_api/app/models/models.dart';
import 'package:kn_fit_api/app/modules/user/view_models/user_save_input_model.dart';

abstract class IUserService {
  Future<void> createUser(UserSaveInputModel user);
  Future<UserModel> login(String email, String password);
}
