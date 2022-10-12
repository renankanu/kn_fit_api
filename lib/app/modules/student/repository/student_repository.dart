import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import '../../../core/core.dart';
import '../../../core/database/i_database_connection.dart';
import '../../../models/models.dart';
import 'i_student_repository.dart';

@LazySingleton(as: IStudentRepository)
class StudentRepository implements IStudentRepository {
  final IDatabaseConnection connection;
  final ILogger log;

  StudentRepository({required this.connection, required this.log});

  String baseQuerySelect = '''
SELECT id,
  avatar,
  full_name,
  email,
  called_by,
  gender+0 as gender,
  password,
  create_time,
  update_time,
  personal_training_id
FROM student''';

  @override
  Future<void> createStudent(StudentModel student) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      final isUserRegister = await conn
          .query('$baseQuerySelect where email = ? ', [student.email]);

      if (isUserRegister.isEmpty) {
        const query =
            'insert into student (avatar, full_name, email, called_by, gender, password, personal_training_id) values (?, ?, ?, ?, ?, ?, ?)';

        await conn.query(query, [
          student.avatar,
          student.fullName,
          student.email,
          student.calledBy,
          student.gender.value,
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
      final query = '$baseQuerySelect where email = ? and password = ?';
      final result = await conn.query(query, [
        email,
        CryptoHelper.generatedSha256Hash(password),
      ]);

      if (result.isNotEmpty) {
        final resultRow = result.first;
        final student = StudentModel.fromDataBase(resultRow.fields);
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
  Future<List<StudentModel>> getAll() async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      final query = baseQuerySelect;
      final result = await conn.query(query);

      final students = result.map((resultRow) {
        return StudentModel.fromDataBase(resultRow.fields);
      }).toList();
      return students;
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
      final result = await _hasStudentById(conn: conn, id: id);

      if (result.isNotEmpty) {
        final resultRow = result.first;
        return StudentModel.fromDataBase(resultRow.fields);
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
  Future<StudentModel> getInfoByEmail(String email) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      final query = '$baseQuerySelect where email = ?';
      final result = await conn.query(query, [email]);

      if (result.isNotEmpty) {
        final resultRow = result.first;
        return StudentModel.fromDataBase(resultRow.fields);
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
  Future<void> updateStudent(StudentModel student) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      const query =
          'update student set avatar = ?, full_name = ?, email = ?, called_by = ?, gender = ?, personal_training_id = ? where id = ?';
      await conn.query(query, [
        student.avatar,
        student.fullName,
        student.email,
        student.calledBy,
        student.gender.value,
        student.personalTrainingId,
        student.id,
      ]);
    } on MySqlException catch (e, s) {
      log.error('Erro ao atualizar o usuário', e, s);
      throw DatabaseException(
        message: 'Erro ao atualizar o usuário',
        exception: e,
      );
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<void> deleteStudent(int id) async {
    MySqlConnection? conn;
    try {
      conn = await connection.openConnection();
      final result = await _hasStudentById(conn: conn, id: id);
      if (result.isEmpty) {
        throw UserNotFoundException(message: 'Usuário não encontrado');
      }
      const query = 'delete from student WHERE (id = ?)';
      await conn.query(query, [id]);
    } on MySqlException catch (e, s) {
      log.error('Erro ao atualizar o usuário', e, s);
    } finally {
      await conn?.close();
    }
  }

  Future<Results> _hasStudentById({
    required MySqlConnection conn,
    required int id,
  }) async {
    final query = '$baseQuerySelect where id = ?';
    final result = await conn.query(query, [id]);
    return result;
  }
}
