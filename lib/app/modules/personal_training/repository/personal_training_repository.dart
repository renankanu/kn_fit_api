import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import '../../../core/core.dart';
import '../../../core/database/i_database_connection.dart';
import '../../../models/personal_training_model.dart';
import 'i_personal_training_repository.dart';

@LazySingleton(as: IPersonalTrainingRepository)
class PersonalTrainingRepository implements IPersonalTrainingRepository {
  final IDatabaseConnection connection;
  final ILogger log;

  PersonalTrainingRepository({required this.connection, required this.log});
  @override
  Future<void> createPersonalTraining(
    PersonalTrainingModel personalTraining,
  ) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      const query =
          'insert into personal_training (full_name, email, password, cref_type, cref_number) values (?, ?, ?, ?, ?)';

      await conn.query(query, [
        personalTraining.fullName,
        personalTraining.email,
        CryptoHelper.generatedSha256Hash(personalTraining.password),
        personalTraining.crefType,
        personalTraining.crefNumber,
      ]);
    } on MySqlException catch (e, s) {
      log.error('Erro ao criar o Personal Training', e, s);
      throw DatabaseException(
        message: 'Erro ao criar o Personal Training',
        exception: e,
      );
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<List<PersonalTrainingModel>> getAll() async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      const query = 'select * from personal_training';
      final results = await conn.query(query);
      return results.map((row) {
        return PersonalTrainingModel(
          id: row['id'],
          fullName: row['full_name'],
          email: row['email'],
          password: row['password'],
          crefType: row['cref_type'],
          crefNumber: row['cref_number'],
          createdAt: row['create_time'],
          updatedAt: row['update_time'],
        );
      }).toList();
    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar todos os Personal Trainings', e, s);
      throw DatabaseException(
        message: 'Erro ao buscar todos os Personal Trainings',
        exception: e,
      );
    } finally {
      await conn?.close();
    }
  }
}
