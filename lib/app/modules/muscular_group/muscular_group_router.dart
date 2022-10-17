import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/routers/routers.dart';
import 'controller/muscular_group_controller.dart';

class MuscularGroupRouter implements IRouter {
  @override
  void configure(Router router) {
    final muscularGroupController = GetIt.I.get<MuscularGroupController>();

    router.mount('/muscular-group', muscularGroupController.router);
  }
}
