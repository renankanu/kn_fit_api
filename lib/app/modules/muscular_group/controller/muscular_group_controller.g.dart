// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscular_group_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$MuscularGroupControllerRouter(MuscularGroupController service) {
  final router = Router();
  router.add('POST', r'/', service.create);
  router.add('GET', r'/', service.listAll);
  return router;
}
