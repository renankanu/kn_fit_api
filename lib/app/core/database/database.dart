import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import '../config/config.dart';
import 'i_database_connection.dart';

@LazySingleton(as: IDatabaseConnection)
class Database implements IDatabaseConnection {
  final DatabaseConnectionConfiguration _configuration;

  Database(this._configuration);

  @override
  Future<MySqlConnection> openConnection() {
    return MySqlConnection.connect(
      ConnectionSettings(
        host: _configuration.host,
        port: _configuration.port,
        user: _configuration.user,
        password: _configuration.password,
        db: _configuration.databaseName,
      ),
    );
  }
}
