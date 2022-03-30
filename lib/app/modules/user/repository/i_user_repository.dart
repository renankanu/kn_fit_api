import 'package:kn_fit_api/app/models/models.dart';

abstract class IUserRepository {
  Future<void> createUser(UserModel user);
  Future<UserModel> login(String email, String password);
}
