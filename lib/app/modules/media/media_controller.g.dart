// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$MediaControllerRouter(MediaController service) {
  final router = Router();
  router.add('POST', r'/image/upload', service.uploadAvatar);
  router.add('GET', r'/image/<image>', service.getAvatar);
  return router;
}
