import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import './i_muscular_group_repository.dart';
import '../../../core/core.dart';
import '../../../core/database/i_database_connection.dart';
import '../../../models/muscular_group_model.dart';

@LazySingleton(as: IMuscularGroupRepository)
class MuscularGroupRepository implements IMuscularGroupRepository {
  final IDatabaseConnection connection;
  final ILogger log;

  MuscularGroupRepository({
    required this.connection,
    required this.log,
  });

  @override
  Future<void> createMuscularGroup(MuscularGroupModel muscularGroup) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
    } on MySqlException catch (e, s) {
      log.error('Erro ao criar o Grupo Muscular', e, s);
      throw DatabaseException(
        message: 'Erro ao criar o Grupo Muscular',
        exception: e,
      );
    } finally {
      await conn?.close();
    }
  }
}
