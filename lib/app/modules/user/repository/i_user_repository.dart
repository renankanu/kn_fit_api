import 'package:kn_fit_api/app/models/models.dart';

abstract class IUserRepository {
  Future<UserModel> createUser(UserModel user);
}
