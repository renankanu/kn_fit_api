import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/routers/i_router.dart';
import 'controller/exercise_controller.dart';

class ExerciseRouter implements IRouter {
  @override
  void configure(Router router) {
    final exerciseController = GetIt.I.get<ExerciseController>();

    router.mount('/exercise', exerciseController.router);
  }
}
