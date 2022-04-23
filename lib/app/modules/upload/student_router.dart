import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/routers/i_router.dart';
import 'upload_controller.dart';

class UploadRouter implements IRouter {
  @override
  void configure(Router router) {
    final uploadController = GetIt.I.get<UploadController>();

    router.mount('/upload', uploadController.router);
  }
}
