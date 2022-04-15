import '../../../models/models.dart';
import '../view_models/student_save_input_model.dart';

abstract class IStudentService {
  Future<void> createStudent(StudentSaveInputModel student);
  Future<StudentModel> login(String email, String password);
  Future<List<StudentModel>> getAll();
  Future<StudentModel> getInfo(int id);
}
