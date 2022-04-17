// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$ExerciseControllerRouter(ExerciseController service) {
  final router = Router();
  router.add('POST', r'/register', service.saveExercise);
  router.add('GET', r'/', service.getAll);
  router.add('GET', r'/{id}', service.getDetail);
  return router;
}
