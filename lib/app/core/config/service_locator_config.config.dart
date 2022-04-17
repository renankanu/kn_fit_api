// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/exercise/controller/exercise_controller.dart' as _i22;
import '../../modules/exercise/repository/exercise_repository.dart' as _i7;
import '../../modules/exercise/repository/i_exercise_repository.dart' as _i6;
import '../../modules/exercise/service/exercise_service.dart' as _i10;
import '../../modules/exercise/service/i_exercise_service.dart' as _i9;
import '../../modules/personal_training/controller/personal_training_controller.dart'
    as _i20;
import '../../modules/personal_training/repository/i_personal_training_repository.dart'
    as _i11;
import '../../modules/personal_training/repository/personal_training_repository.dart'
    as _i12;
import '../../modules/personal_training/service/i_personal_training_service.dart'
    as _i13;
import '../../modules/personal_training/service/personal_training_service.dart'
    as _i14;
import '../../modules/student/controller/student_controller.dart' as _i21;
import '../../modules/student/repository/i_student_repository.dart' as _i16;
import '../../modules/student/repository/student_repository.dart' as _i17;
import '../../modules/student/service/i_student_service.dart' as _i18;
import '../../modules/student/service/student_service.dart' as _i19;
import '../core.dart' as _i8;
import '../database/database.dart' as _i4;
import '../database/i_database_connection.dart' as _i3;
import '../logger/i_logger.dart' as _i15;
import 'config.dart' as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.IDatabaseConnection>(
      () => _i4.Database(get<_i5.DatabaseConnectionConfiguration>()));
  gh.lazySingleton<_i6.IExerciseRepository>(() => _i7.ExerciseRepository(
      connection: get<_i3.IDatabaseConnection>(), log: get<_i8.ILogger>()));
  gh.lazySingleton<_i9.IExerciseService>(() => _i10.ExerciseService(
      exerciseRepository: get<_i6.IExerciseRepository>(),
      log: get<_i8.ILogger>()));
  gh.lazySingleton<_i11.IPersonalTrainingRepository>(() =>
      _i12.PersonalTrainingRepository(
          connection: get<_i3.IDatabaseConnection>(), log: get<_i8.ILogger>()));
  gh.lazySingleton<_i13.IPersonalTrainingService>(() =>
      _i14.PersonalTrainingService(
          personalTrainingRepository: get<_i11.IPersonalTrainingRepository>(),
          log: get<_i15.ILogger>()));
  gh.lazySingleton<_i16.IStudentRepository>(() => _i17.StudentRepository(
      connection: get<_i3.IDatabaseConnection>(), log: get<_i8.ILogger>()));
  gh.lazySingleton<_i18.IStudentService>(() => _i19.StudentService(
      studentRepository: get<_i16.IStudentRepository>(),
      log: get<_i8.ILogger>()));
  gh.factory<_i20.PersonalTrainingController>(() =>
      _i20.PersonalTrainingController(
          personalTrainingService: get<_i13.IPersonalTrainingService>(),
          log: get<_i8.ILogger>()));
  gh.factory<_i21.StudentController>(() => _i21.StudentController(
      studentService: get<_i18.IStudentService>(), log: get<_i8.ILogger>()));
  gh.factory<_i22.ExerciseController>(() => _i22.ExerciseController(
      exerciseService: get<_i9.IExerciseService>(), log: get<_i8.ILogger>()));
  return get;
}
