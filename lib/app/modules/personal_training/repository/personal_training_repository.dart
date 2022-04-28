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
      final isUserRegister = await conn
          .query('SELECT id FROM personal_training where email = ? ', [
        personalTraining.email,
      ]);
      if (isUserRegister.isEmpty) {
        const query =
            'insert into personal_training (full_name, email, password, cref_type, cref_number) values (?, ?, ?, ?, ?)';

        await conn.query(query, [
          personalTraining.fullName,
          personalTraining.email,
          CryptoHelper.generatedSha256Hash(personalTraining.password),
          personalTraining.crefType,
          personalTraining.crefNumber,
        ]);
      } else {
        throw EmailAlreadyRegistered();
      }
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
      return results.map((resultRow) {
        return PersonalTrainingModel.fromDataBase(resultRow.fields);
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

  @override
  Future<PersonalTrainingModel> login(String email, String password) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      const query =
          'select * from personal_training where email = ? and password = ?';
      final result = await conn.query(query, [
        email,
        CryptoHelper.generatedSha256Hash(password),
      ]);

      if (result.isNotEmpty) {
        final resultRow = result.first;
        final personalTraining =
            PersonalTrainingModel.fromDataBase(resultRow.fields);
        return personalTraining;
      } else {
        throw UserNotFoundException(message: 'Email ou senha inválidos');
      }
    } on MySqlException catch (e, s) {
      log.error('Erro ao fazer login com o Personal Training', e, s);
      throw DatabaseException(
        message: 'Erro ao fazer login com o Personal Training',
        exception: e,
      );
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<PersonalTrainingModel> getInfo(int id) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      const query = 'select * from personal_training where id = ?';
      final result = await conn.query(query, [id]);

      if (result.isNotEmpty) {
        final resultRow = result.first;
        final personalTraining =
            PersonalTrainingModel.fromDataBase(resultRow.fields);
        return personalTraining;
      } else {
        throw UserNotFoundException(message: 'Usuário não encontrado');
      }
    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar o Personal Training', e, s);
      throw DatabaseException(
        message: 'Erro ao buscar o Personal Training',
        exception: e,
      );
    } finally {
      await conn?.close();
    }
  }
}
