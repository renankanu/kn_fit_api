import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';
import 'package:uuid/uuid.dart';

import '../../../core/core.dart';
import '../../../core/database/i_database_connection.dart';
import '../../../models/user_model.dart';
import 'i_user_repository.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  final IDatabaseConnection connection;
  final ILogger log;

  UserRepository({required this.connection, required this.log});

  @override
  Future<void> createUser(UserModel user) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      final isUserRegister =
          await conn.query('select * from user where email = ? ', [user.email]);

      if (isUserRegister.isEmpty) {
        const query =
            'insert into user (id, full_name, email, password) values (?, ?, ?, ?)';
        final uuid = const Uuid().v4();

        await conn.query(query, [
          uuid,
          user.fullName,
          user.email,
          CryptoHelper.generatedSha256Hash(user.password),
        ]);
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

  @override
  Future<UserModel> login(String email, String password) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      const query = 'select * from user where email = ? and password = ?';
      final result = await conn.query(query, [
        email,
        CryptoHelper.generatedSha256Hash(password),
      ]);

      if (result.isNotEmpty) {
        final userSqlData = result.first;
        final user = UserModel(
          id: userSqlData['id'],
          fullName: userSqlData['full_name'],
          email: userSqlData['email'],
          password: userSqlData['password'],
          createdAt: userSqlData['created_at'],
          updatedAt: userSqlData['updated_at'],
        );
        return user;
      } else {
        throw UserNotFoundException(message: 'Email ou senha inválidos');
      }
    } on MySqlException catch (e, s) {
      log.error('Erro ao fazer login com o usuário', e, s);
      throw DatabaseException(
        message: 'Erro ao fazer login com o usuário',
        exception: e,
      );
    } finally {
      await conn?.close();
    }
  }
}
