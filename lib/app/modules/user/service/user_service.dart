import 'package:injectable/injectable.dart';

import '../../../core/core.dart';
import '../../../models/user_model.dart';
import '../repository/i_user_repository.dart';
import '../view_models/user_save_input_model.dart';
import 'i_user_service.dart';

@LazySingleton(as: IUserService)
class UserService implements IUserService {
  IUserRepository userRepository;
  ILogger log;

  UserService({
    required this.userRepository,
    required this.log,
  });

  @override
  Future<void> createUser(UserSaveInputModel user) {
    final userEntity = UserModel(
      fullName: user.fullName,
      email: user.email,
      password: user.password,
    );

    return userRepository.createUser(userEntity);
  }

  @override
  Future<UserModel> login(String email, String password) {
    return userRepository.login(email, password);
  }
}
