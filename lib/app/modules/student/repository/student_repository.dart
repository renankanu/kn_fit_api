import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import '../../../core/core.dart';
import '../../../core/database/i_database_connection.dart';
import '../../../models/student_model.dart';
import 'i_student_repository.dart';

@LazySingleton(as: IStudentRepository)
class StudentRepository implements IStudentRepository {
  final IDatabaseConnection connection;
  final ILogger log;

  StudentRepository({required this.connection, required this.log});

  @override
  Future<void> createStudent(StudentModel student) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      final isUserRegister = await conn
          .query('select * from student where email = ? ', [student.email]);

      if (isUserRegister.isEmpty) {
        const query =
            'insert into student (full_name, email, password, personal_training_id) values (?, ?, ?, ?)';

        await conn.query(query, [
          student.fullName,
          student.email,
          CryptoHelper.generatedSha256Hash(student.password),
          student.personalTrainingId,
        ]);
      } else {
        throw EmailAlreadyRegistered();
      }
    } on MySqlException catch (e, s) {
      log.error('Erro ao criar o Aluno', e, s);
      throw DatabaseException(message: 'Erro ao criar o Aluno', exception: e);
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<StudentModel> login(String email, String password) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      const query = 'select * from student where email = ? and password = ?';
      final result = await conn.query(query, [
        email,
        CryptoHelper.generatedSha256Hash(password),
      ]);

      if (result.isNotEmpty) {
        final userSqlData = result.first;
        final student = StudentModel(
          id: userSqlData['id'],
          fullName: userSqlData['full_name'],
          email: userSqlData['email'],
          password: userSqlData['password'],
          personalTrainingId: userSqlData['personal_training_id'],
          createTime: userSqlData['created_at'],
          updateTime: userSqlData['updated_at'],
        );
        return student;
      } else {
        throw UserNotFoundException(message: 'Email ou senha inválidos');
      }
    } on MySqlException catch (e, s) {
      log.error('Erro ao fazer login com o usuário', e, s);
      throw DatabaseException(
        message: 'Erro ao fazer login com o usuário',
        exception: e,
      );
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<StudentModel> getStudentById(int id) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      const query = 'select * from student where id = ?';
      final result = await conn.query(query, [id]);

      if (result.isNotEmpty) {
        final userSqlData = result.first;
        final student = StudentModel(
          id: userSqlData['id'],
          fullName: userSqlData['full_name'],
          email: userSqlData['email'],
          password: userSqlData['password'],
          personalTrainingId: userSqlData['personal_training_id'],
          createTime: userSqlData['create_time'],
          updateTime: userSqlData['update_time'],
        );
        return student;
      } else {
        throw UserNotFoundException(message: 'Usuário não encontrado');
      }
    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar o usuário', e, s);
      throw DatabaseException(
        message: 'Erro ao buscar o usuário',
        exception: e,
      );
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<List<StudentModel>> getAll() async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      const query = 'select * from student';
      final result = await conn.query(query);

      if (result.isNotEmpty) {
        final students = result.map((userSqlData) {
          final student = StudentModel(
            id: userSqlData['id'],
            fullName: userSqlData['full_name'],
            email: userSqlData['email'],
            password: userSqlData['password'],
            personalTrainingId: userSqlData['personal_training_id'],
            createTime: userSqlData['create_time'],
            updateTime: userSqlData['update_time'],
          );
          return student;
        }).toList();
        return students;
      } else {
        throw UserNotFoundException(message: 'Usuário não encontrado');
      }
    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar todos os usuários', e, s);
      throw DatabaseException(
        message: 'Erro ao buscar todos os usuários',
        exception: e,
      );
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<StudentModel> getInfo(int id) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      const query = 'select * from student where id = ?';
      final result = await conn.query(query, [id]);

      if (result.isNotEmpty) {
        final userSqlData = result.first;
        final student = StudentModel(
          id: userSqlData['id'],
          fullName: userSqlData['full_name'],
          email: userSqlData['email'],
          password: userSqlData['password'],
          personalTrainingId: userSqlData['personal_training_id'],
          createTime: userSqlData['create_time'],
          updateTime: userSqlData['update_time'],
        );
        return student;
      } else {
        throw UserNotFoundException(message: 'Usuário não encontrado');
      }
    } on MySqlException catch (e, s) {
      log.error('Erro ao buscar o usuário', e, s);
      throw DatabaseException(
        message: 'Erro ao buscar o usuário',
        exception: e,
      );
    } finally {
      await conn?.close();
    }
  }
}
