import 'package:dotenv/dotenv.dart';
import 'package:mysql1/mysql1.dart';

class Database {
  Future<MySqlConnection> openConnection() async {
    return MySqlConnection.connect(
      ConnectionSettings(
        host: env['databaseHost'] ?? 'localhost',
        port: int.tryParse(env['databasePort']!) ?? 3306,
        user: env['databaseUser'],
        password: env['databasePassword'],
        db: env['databaseName'],
      ),
    );
  }
}
