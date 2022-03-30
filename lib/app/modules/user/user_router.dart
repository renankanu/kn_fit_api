import 'package:get_it/get_it.dart';
import 'package:kn_fit_api/app/core/routers/i_router.dart';
import 'package:shelf_router/shelf_router.dart';

import 'controller/auth_controller.dart';

class UserRouter implements IRouter {
  @override
  void configure(Router router) {
    final authController = GetIt.I.get<AuthController>();

    router.mount('/user', authController.router);
  }
}
