// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscle_group_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$MuscleGroupControllerRouter(MuscleGroupController service) {
  final router = Router();
  router.add('POST', r'/', service.create);
  router.add('GET', r'/', service.listAll);
  router.add('GET', r'/<id|[0-9]+>', service.getDetail);
  return router;
}
