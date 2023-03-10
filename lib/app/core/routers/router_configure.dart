import 'package:shelf_router/shelf_router.dart';

import '../../modules/exercise/exercise_router.dart';
import '../../modules/media/media_router.dart';
import '../../modules/muscle_group/muscle_group_router.dart';
import '../../modules/personal_training/personal_training_router.dart';
import '../../modules/student/student_router.dart';
import 'i_router.dart';

class RouterConfigure {
  final Router _router;
  final List<IRouter> _routers = [
    ExerciseRouter(),
    MediaRouter(),
    MuscleGroupRouter(),
    StudentRouter(),
    PersonalTrainingRouter(),
  ];

  RouterConfigure(this._router);

  // ignore: avoid_function_literals_in_foreach_calls
  void configure() => _routers.forEach((r) => r.configure(_router));
}
