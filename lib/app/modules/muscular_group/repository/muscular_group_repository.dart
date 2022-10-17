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
  Future<void> create(MuscularGroupModel muscularGroup) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      const query = 'insert into muscular_group (name, ) values (?)';
      await conn.query(
        query,
        [
          muscularGroup.name,
        ],
      );
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

  @override
  Future<List<MuscularGroupModel>> getAll() async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      final result = await conn.query('select * from muscular_group');
      return result
          .map(
            (row) => MuscularGroupModel(
              id: row['id'],
              name: row['name'],
            ),
          )
          .toList();
    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar os Grupos Musculares', e, s);
      throw DatabaseException(
        message: 'Erro ao buscar os Grupos Musculares',
        exception: e,
      );
    } finally {
      await conn?.close();
    }
  }
}
