import 'package:kn_fit_api/app/core/core.dart';
import 'package:kn_fit_api/app/core/exceptions/email_already_registered.dart';
import 'package:kn_fit_api/app/models/user_model.dart';
import 'package:mysql1/mysql1.dart';

class UserRepository {
  Future<void> save(UserModel user) async {
    MySqlConnection? connection;
    try {
      connection = await Database().openConnection();
      final isUserRegister = await connection
          .query('select * from user where email = ? ', [user.email]);
      if (isUserRegister.isEmpty) {
        await connection.query(
            'insert into user (name, email, password) values (?, ?, ?)',
            [user.name, user.email, user.password]);
      } else {
        throw EmailAlreadyRegistered();
      }
    } on MySqlException catch (e, s) {
      print(e);
      print(s);
      throw Exception();
    } finally {
      await connection?.close();
    }
  }
}
