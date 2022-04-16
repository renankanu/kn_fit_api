import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import '../../../core/core.dart';
import '../../../core/database/i_database_connection.dart';
import '../../../models/exercise_model.dart';
import 'i_exercise_repository.dart';

@LazySingleton(as: IExerciseRepository)
class ExerciseRepository implements IExerciseRepository {
  final IDatabaseConnection connection;
  final ILogger log;

  ExerciseRepository({required this.connection, required this.log});

  @override
  Future<void> createExercise(ExerciseModel exercise) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      const query =
          'insert into exercise (name, description, image_url, video_url, create_time, update_time) values (?, ?, ?, ?, ?, ?)';

      await conn.query(query, [
        exercise.name,
        exercise.description,
        exercise.imageUrl,
        exercise.videoUrl,
        exercise.createTime,
        exercise.updateTime,
      ]);
    } on MySqlException catch (e, s) {
      log.error('Erro ao criar o Exercício', e, s);
      throw DatabaseException(
        message: 'Erro ao criar o Exercício',
        exception: e,
      );
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<List<ExerciseModel>> getAll() async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      const query = 'select * from exercise';
      final results = await conn.query(query);
      return results.map((row) => ExerciseModel.fromJson(row)).toList();
    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar todos os Exercícios', e, s);
      throw DatabaseException(
        message: 'Erro ao buscar todos os Exercícios',
        exception: e,
      );
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<ExerciseModel> getDetail(int id) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      const query = 'select * from exercise where id = ?';
      final results = await conn.query(query, [id]);
      return ExerciseModel.fromJson(results.first);
    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar o Exercício', e, s);
      throw DatabaseException(
        message: 'Erro ao buscar o Exercício',
        exception: e,
      );
    } finally {
      await conn?.close();
    }
  }
}
