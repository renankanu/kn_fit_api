import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/routers/i_router.dart';
import 'controller/documentation_controller.dart';

class DocumentationRouter implements IRouter {
  @override
  void configure(Router router) {
    final documentationController = GetIt.I.get<DocumentationController>();

    router.mount('/documentation', documentationController.router);
  }
}
