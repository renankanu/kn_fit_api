import 'package:injectable/injectable.dart';

import '../../../core/core.dart';
import '../../../models/student_model.dart';
import '../repository/i_student_repository.dart';
import '../view_models/student_save_input_model.dart';
import 'i_student_service.dart';

@LazySingleton(as: IStudentService)
class StudentService implements IStudentService {
  IStudentRepository studentRepository;
  ILogger log;

  StudentService({
    required this.studentRepository,
    required this.log,
  });

  @override
  Future<void> createStudent(StudentSaveInputModel student) {
    final studentEntity = StudentModel(
      fullName: student.fullName,
      email: student.email,
      password: student.password,
    );

    return studentRepository.createStudent(studentEntity);
  }

  @override
  Future<StudentModel> login(String email, String password) {
    return studentRepository.login(email, password);
  }
}
