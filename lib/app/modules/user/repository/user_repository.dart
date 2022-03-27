import 'package:injectable/injectable.dart';
import 'package:kn_fit_api/app/core/core.dart';
import 'package:kn_fit_api/app/core/database/i_database_connection.dart';
import 'package:kn_fit_api/app/models/user_model.dart';
import 'package:kn_fit_api/app/modules/user/repository/i_user_repository.dart';
import 'package:mysql1/mysql1.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  final IDatabaseConnection connection;
  final ILogger log;

  UserRepository({required this.connection, required this.log});

  @override
  Future<UserModel> createUser(UserModel user) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      final isUserRegister =
          await conn.query('select * from user where email = ? ', [user.email]);

      if (isUserRegister.isEmpty) {
        final query = 'insert into user (id, email, password) values (?, ?, ?)';
        final uuid = Uuid().v4();

        await conn.query(query, [
          uuid,
          user.email,
          CryptoHelper.generatedSha256Hash(user.password),
        ]);

        return user.copyWith(id: uuid, password: null);
      } else {
        throw EmailAlreadyRegistered();
      }
    } on MySqlException catch (e, s) {
      log.error('Erro ao criar usuário', e, s);
      throw DatabaseException(message: 'Erro ao criar usuário', exception: e);
    } finally {
      await conn?.close();
    }
  }
}
