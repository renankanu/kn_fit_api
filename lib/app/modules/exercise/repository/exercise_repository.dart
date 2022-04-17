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
          'insert into exercise (name, description, image_url, video_url) values (?, ?, ?, ?)';

      await conn.query(query, [
        exercise.name,
        exercise.description,
        exercise.imageUrl,
        exercise.videoUrl,
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
      return results
          .map(
            (row) => ExerciseModel(
              id: row['id'],
              name: row['name'],
              description: row['description'],
              imageUrl: row['image_url'],
              videoUrl: row['video_url'],
              createTime: row['create_time'],
              updateTime: row['update_time'],
            ),
          )
          .toList();
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
      if (results.isNotEmpty) {
        final exerciseSqlData = results.first;
        return ExerciseModel(
          id: exerciseSqlData['id'],
          name: exerciseSqlData['name'],
          description: exerciseSqlData['description'],
          imageUrl: exerciseSqlData['image_url'],
          videoUrl: exerciseSqlData['video_url'],
          createTime: exerciseSqlData['create_time'],
          updateTime: exerciseSqlData['update_time'],
        );
      } else {
        throw UserNotFoundException(
          message: 'Exercício não encontrado',
        );
      }
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
