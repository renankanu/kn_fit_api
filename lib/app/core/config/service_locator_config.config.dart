// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/documentation/controller/documentation_controller.dart'
    as _i3;
import '../../modules/exercise/controller/exercise_controller.dart' as _i29;
import '../../modules/exercise/repository/exercise_repository.dart' as _i8;
import '../../modules/exercise/repository/i_exercise_repository.dart' as _i7;
import '../../modules/exercise/service/exercise_service.dart' as _i11;
import '../../modules/exercise/service/i_exercise_service.dart' as _i10;
import '../../modules/media/media_controller.dart' as _i25;
import '../../modules/muscle_group/controller/muscle_group_controller.dart'
    as _i26;
import '../../modules/muscle_group/repository/i_muscle_group_repository.dart'
    as _i12;
import '../../modules/muscle_group/repository/muscle_group_repository.dart'
    as _i13;
import '../../modules/muscle_group/service/i_muscle_group_service.dart' as _i14;
import '../../modules/muscle_group/service/muscle_group_service.dart' as _i15;
import '../../modules/personal_training/controller/personal_training_controller.dart'
    as _i27;
import '../../modules/personal_training/repository/i_personal_training_repository.dart'
    as _i17;
import '../../modules/personal_training/repository/personal_training_repository.dart'
    as _i18;
import '../../modules/personal_training/service/i_personal_training_service.dart'
    as _i19;
import '../../modules/personal_training/service/personal_training_service.dart'
    as _i20;
import '../../modules/student/controller/student_controller.dart' as _i28;
import '../../modules/student/repository/i_student_repository.dart' as _i21;
import '../../modules/student/repository/student_repository.dart' as _i22;
import '../../modules/student/service/i_student_service.dart' as _i23;
import '../../modules/student/service/student_service.dart' as _i24;
import '../core.dart' as _i9;
import '../database/database.dart' as _i5;
import '../database/i_database_connection.dart' as _i4;
import '../logger/i_logger.dart' as _i16;
import 'config.dart' as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.DocumentationController>(() => _i3.DocumentationController());
  gh.lazySingleton<_i4.IDatabaseConnection>(
      () => _i5.Database(get<_i6.DatabaseConnectionConfiguration>()));
  gh.lazySingleton<_i7.IExerciseRepository>(() => _i8.ExerciseRepository(
      connection: get<_i4.IDatabaseConnection>(), log: get<_i9.ILogger>()));
  gh.lazySingleton<_i10.IExerciseService>(() => _i11.ExerciseService(
      exerciseRepository: get<_i7.IExerciseRepository>(),
      log: get<_i9.ILogger>()));
  gh.lazySingleton<_i12.IMuscleGroupRepository>(() =>
      _i13.MuscleGroupRepository(
          connection: get<_i4.IDatabaseConnection>(), log: get<_i9.ILogger>()));
  gh.lazySingleton<_i14.IMuscleGroupService>(() => _i15.MuscleGroupService(
      muscleGroupRepository: get<_i12.IMuscleGroupRepository>(),
      log: get<_i16.ILogger>()));
  gh.lazySingleton<_i17.IPersonalTrainingRepository>(() =>
      _i18.PersonalTrainingRepository(
          connection: get<_i4.IDatabaseConnection>(), log: get<_i9.ILogger>()));
  gh.lazySingleton<_i19.IPersonalTrainingService>(() =>
      _i20.PersonalTrainingService(
          personalTrainingRepository: get<_i17.IPersonalTrainingRepository>(),
          log: get<_i16.ILogger>()));
  gh.lazySingleton<_i21.IStudentRepository>(() => _i22.StudentRepository(
      connection: get<_i4.IDatabaseConnection>(), log: get<_i9.ILogger>()));
  gh.lazySingleton<_i23.IStudentService>(() => _i24.StudentService(
      studentRepository: get<_i21.IStudentRepository>(),
      log: get<_i9.ILogger>()));
  gh.factory<_i25.MediaController>(
      () => _i25.MediaController(log: get<_i9.ILogger>()));
  gh.factory<_i26.MuscleGroupController>(() => _i26.MuscleGroupController(
      muscleGroupService: get<_i14.IMuscleGroupService>(),
      log: get<_i9.ILogger>()));
  gh.factory<_i27.PersonalTrainingController>(() =>
      _i27.PersonalTrainingController(
          personalTrainingService: get<_i19.IPersonalTrainingService>(),
          log: get<_i9.ILogger>()));
  gh.factory<_i28.StudentController>(() => _i28.StudentController(
      studentService: get<_i23.IStudentService>(), log: get<_i9.ILogger>()));
  gh.factory<_i29.ExerciseController>(() => _i29.ExerciseController(
      exerciseService: get<_i10.IExerciseService>(), log: get<_i9.ILogger>()));
  return get;
}
