import '../../../models/models.dart';
import '../view_models/user_save_input_model.dart';

abstract class IUserService {
  Future<void> createUser(UserSaveInputModel user);
  Future<UserModel> login(String email, String password);
}
