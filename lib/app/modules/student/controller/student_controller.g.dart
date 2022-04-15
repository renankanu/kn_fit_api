// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$StudentControllerRouter(StudentController service) {
  final router = Router();
  router.add('POST', r'/register', service.saveStudent);
  router.add('POST', r'/login', service.login);
  router.add('GET', r'/info', service.getStudentInfo);
  router.add('GET', r'/all', service.getAllStudents);
  return router;
}
