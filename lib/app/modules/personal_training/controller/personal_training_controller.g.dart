// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_training_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$PersonalTrainingControllerRouter(PersonalTrainingController service) {
  final router = Router();
  router.add('POST', r'/register', service.savePersonalTraining);
  router.add('GET', r'/', service.getAllPersonalTrainings);
  return router;
}
