// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$UploadControllerRouter(UploadController service) {
  final router = Router();
  router.add('POST', r'/', service.uploadAvatar);
  router.add('GET', r'/', service.getAvatar);
  return router;
}
