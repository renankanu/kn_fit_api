import 'package:shelf_router/shelf_router.dart';

import '../../modules/student/student_router.dart';
import 'i_router.dart';

class RouterConfigure {
  final Router _router;
  final List<IRouter> _routers = [
    StudentRouter(),
  ];

  RouterConfigure(this._router);

  // ignore: avoid_function_literals_in_foreach_calls
  void configure() => _routers.forEach((r) => r.configure(_router));
}
