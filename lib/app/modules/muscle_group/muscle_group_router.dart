import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/routers/routers.dart';
import 'controller/muscle_group_controller.dart';

class MuscleGroupRouter implements IRouter {
  @override
  void configure(Router router) {
    final muscleGroupController = GetIt.I.get<MuscleGroupController>();

    router.mount('/muscle-group', muscleGroupController.router);
  }
}
