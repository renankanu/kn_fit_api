// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscle_group_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$MuscleGroupControllerRouter(MuscleGroupController service) {
  final router = Router();
  router.add('POST', r'/', service.create);
  router.add('GET', r'/', service.listAll);
  return router;
}