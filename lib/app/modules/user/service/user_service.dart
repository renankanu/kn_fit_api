import 'package:injectable/injectable.dart';
import 'package:kn_fit_api/app/core/core.dart';
import 'package:kn_fit_api/app/models/user_model.dart';
import 'package:kn_fit_api/app/modules/user/repository/i_user_repository.dart';
import 'package:kn_fit_api/app/modules/user/service/i_user_service.dart';
import 'package:kn_fit_api/app/modules/user/view_models/user_save_input_model.dart';

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
