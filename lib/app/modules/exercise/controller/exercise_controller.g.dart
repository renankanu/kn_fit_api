// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$ExerciseControllerRouter(ExerciseController service) {
  final router = Router();
  router.add('POST', r'/register', service.saveExercise);
  router.add('GET', r'/', service.getAll);
  router.add('GET', r'/<id|[0-9]+>', service.getDetail);
  router.add('GET', r'/muscleGroup/<id|[0-9]+>', service.getByMuscleGroup);
  return router;
}
