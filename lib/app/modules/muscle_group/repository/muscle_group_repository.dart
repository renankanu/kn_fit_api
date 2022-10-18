import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import '../../../core/core.dart';
import '../../../core/database/i_database_connection.dart';
import '../../../models/muscle_group_model.dart';
import 'i_muscle_group_repository.dart';

@LazySingleton(as: IMuscleGroupRepository)
class MuscleGroupRepository implements IMuscleGroupRepository {
  final IDatabaseConnection connection;
  final ILogger log;

  MuscleGroupRepository({
    required this.connection,
    required this.log,
  });

  @override
  Future<void> create(MuscleGroupModel muscleGroup) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      const query = 'insert into muscle_group (name, ) values (?)';
      await conn.query(
        query,
        [
          muscleGroup.name,
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
  Future<List<MuscleGroupModel>> getAll() async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      final result = await conn.query('select * from muscle_group');
      return result
          .map(
            (row) => MuscleGroupModel(
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

  @override
  Future<MuscleGroupModel> getDetail(int id) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      final result = await conn.query(
        'select * from muscle_group where id = ?',
        [id],
      );
      return result
          .map(
            (row) => MuscleGroupModel(
              id: row['id'],
              name: row['name'],
            ),
          )
          .first;
    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar o Grupo Muscular', e, s);
      throw DatabaseException(
        message: 'Erro ao buscar o Grupo Muscular',
        exception: e,
      );
    } finally {
      await conn?.close();
    }
  }
}
