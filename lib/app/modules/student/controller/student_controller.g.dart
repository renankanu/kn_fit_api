// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$StudentControllerRouter(StudentController service) {
  final router = Router();
  router.add('POST', r'/register', service.saveStudent);
  router.add('POST', r'/login', service.login);
  return router;
}