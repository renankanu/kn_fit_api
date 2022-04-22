import '../../../models/models.dart';

abstract class IStudentRepository {
  Future<void> createStudent(StudentModel student);
  Future<StudentModel> login(String email, String password);
  Future<List<StudentModel>> getAll();
  Future<StudentModel> getInfo(int id);
  Future<StudentModel> getInfoByEmail(String email);
  Future<void> updateStudent(StudentModel student);
}
