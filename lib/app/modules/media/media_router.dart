import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/routers/i_router.dart';
import 'media_controller.dart';

class MediaRouter implements IRouter {
  @override
  void configure(Router router) {
    final mediaController = GetIt.I.get<MediaController>();

    router.mount('/', mediaController.router);
  }
}
