import '../../../models/models.dart';

abstract class IStudentRepository {
  Future<void> createStudent(StudentModel student);
  Future<StudentModel> login(String email, String password);
  Future<StudentModel> getStudentById(int id);
}
