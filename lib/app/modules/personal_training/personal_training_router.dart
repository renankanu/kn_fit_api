import 'package:get_it/get_it.dart';
// ignore: implementation_imports
import 'package:shelf_router/src/router.dart';

import '../../core/routers/i_router.dart';
import 'controller/personal_training_controller.dart';

class PersonalTrainingRouter implements IRouter {
  @override
  void configure(Router router) {
    final personalTrainingController =
        GetIt.I.get<PersonalTrainingController>();

    router.mount('/personal-training', personalTrainingController.router);
  }
}
