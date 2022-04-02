import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/routers/i_router.dart';
import 'controller/student_controller.dart';

class StudentRouter implements IRouter {
  @override
  void configure(Router router) {
    final studentController = GetIt.I.get<StudentController>();

    router.mount('/student', studentController.router);
  }
}
