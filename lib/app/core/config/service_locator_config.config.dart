// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/exercise/controller/exercise_controller.dart' as _i28;
import '../../modules/exercise/repository/exercise_repository.dart' as _i7;
import '../../modules/exercise/repository/i_exercise_repository.dart' as _i6;
import '../../modules/exercise/service/exercise_service.dart' as _i10;
import '../../modules/exercise/service/i_exercise_service.dart' as _i9;
import '../../modules/media/media_controller.dart' as _i24;
import '../../modules/muscle_group/controller/muscle_group_controller.dart'
    as _i25;
import '../../modules/muscle_group/repository/i_muscle_group_repository.dart'
    as _i11;
import '../../modules/muscle_group/repository/muscle_group_repository.dart'
    as _i12;
import '../../modules/muscle_group/service/i_muscle_group_service.dart' as _i13;
import '../../modules/muscle_group/service/muscle_group_service.dart' as _i14;
import '../../modules/personal_training/controller/personal_training_controller.dart'
    as _i26;
import '../../modules/personal_training/repository/i_personal_training_repository.dart'
    as _i16;
import '../../modules/personal_training/repository/personal_training_repository.dart'
    as _i17;
import '../../modules/personal_training/service/i_personal_training_service.dart'
    as _i18;
import '../../modules/personal_training/service/personal_training_service.dart'
    as _i19;
import '../../modules/student/controller/student_controller.dart' as _i27;
import '../../modules/student/repository/i_student_repository.dart' as _i20;
import '../../modules/student/repository/student_repository.dart' as _i21;
import '../../modules/student/service/i_student_service.dart' as _i22;
import '../../modules/student/service/student_service.dart' as _i23;
import '../core.dart' as _i8;
import '../database/database.dart' as _i4;
import '../database/i_database_connection.dart' as _i3;
import '../logger/i_logger.dart' as _i15;
import 'config.dart' as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.IDatabaseConnection>(
      () => _i4.Database(get<_i5.DatabaseConnectionConfiguration>()));
  gh.lazySingleton<_i6.IExerciseRepository>(() => _i7.ExerciseRepository(
        connection: get<_i3.IDatabaseConnection>(),
        log: get<_i8.ILogger>(),
      ));
  gh.lazySingleton<_i9.IExerciseService>(() => _i10.ExerciseService(
        exerciseRepository: get<_i6.IExerciseRepository>(),
        log: get<_i8.ILogger>(),
      ));
  gh.lazySingleton<_i11.IMuscleGroupRepository>(
      () => _i12.MuscleGroupRepository(
            connection: get<_i3.IDatabaseConnection>(),
            log: get<_i8.ILogger>(),
          ));
  gh.lazySingleton<_i13.IMuscleGroupService>(() => _i14.MuscleGroupService(
        muscleGroupRepository: get<_i11.IMuscleGroupRepository>(),
        log: get<_i15.ILogger>(),
      ));
  gh.lazySingleton<_i16.IPersonalTrainingRepository>(
      () => _i17.PersonalTrainingRepository(
            connection: get<_i3.IDatabaseConnection>(),
            log: get<_i8.ILogger>(),
          ));
  gh.lazySingleton<_i18.IPersonalTrainingService>(
      () => _i19.PersonalTrainingService(
            personalTrainingRepository: get<_i16.IPersonalTrainingRepository>(),
            log: get<_i15.ILogger>(),
          ));
  gh.lazySingleton<_i20.IStudentRepository>(() => _i21.StudentRepository(
        connection: get<_i3.IDatabaseConnection>(),
        log: get<_i8.ILogger>(),
      ));
  gh.lazySingleton<_i22.IStudentService>(() => _i23.StudentService(
        studentRepository: get<_i20.IStudentRepository>(),
        log: get<_i8.ILogger>(),
      ));
  gh.factory<_i24.MediaController>(
      () => _i24.MediaController(log: get<_i8.ILogger>()));
  gh.factory<_i25.MuscleGroupController>(() => _i25.MuscleGroupController(
        muscleGroupService: get<_i13.IMuscleGroupService>(),
        log: get<_i8.ILogger>(),
      ));
  gh.factory<_i26.PersonalTrainingController>(
      () => _i26.PersonalTrainingController(
            personalTrainingService: get<_i18.IPersonalTrainingService>(),
            log: get<_i8.ILogger>(),
          ));
  gh.factory<_i27.StudentController>(() => _i27.StudentController(
        studentService: get<_i22.IStudentService>(),
        log: get<_i8.ILogger>(),
      ));
  gh.factory<_i28.ExerciseController>(() => _i28.ExerciseController(
        exerciseService: get<_i9.IExerciseService>(),
        log: get<_i8.ILogger>(),
      ));
  return get;
}
