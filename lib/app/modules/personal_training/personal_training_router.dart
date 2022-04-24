import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/routers/i_router.dart';
import 'controller/personal_training_controller.dart';

class PersonalTrainingRouter implements IRouter {
  @override
  void configure(Router router) {
    final personalTrainingController =
        GetIt.I.get<PersonalTrainingController>();

    router.mount('/personalTraining', personalTrainingController.router);
  }
}
