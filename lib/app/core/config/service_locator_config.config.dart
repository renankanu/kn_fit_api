// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/exercise/repository/exercise_repository.dart' as _i7;
import '../../modules/exercise/repository/i_exercise_repository.dart' as _i6;
import '../../modules/personal_training/controller/personal_training_controller.dart'
    as _i18;
import '../../modules/personal_training/repository/i_personal_training_repository.dart'
    as _i9;
import '../../modules/personal_training/repository/personal_training_repository.dart'
    as _i10;
import '../../modules/personal_training/service/i_personal_training_service.dart'
    as _i11;
import '../../modules/personal_training/service/personal_training_service.dart'
    as _i12;
import '../../modules/student/controller/student_controller.dart' as _i19;
import '../../modules/student/repository/i_student_repository.dart' as _i14;
import '../../modules/student/repository/student_repository.dart' as _i15;
import '../../modules/student/service/i_student_service.dart' as _i16;
import '../../modules/student/service/student_service.dart' as _i17;
import '../core.dart' as _i8;
import '../database/database.dart' as _i4;
import '../database/i_database_connection.dart' as _i3;
import '../logger/i_logger.dart' as _i13;
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
  gh.lazySingleton<_i9.IPersonalTrainingRepository>(() =>
      _i10.PersonalTrainingRepository(
          connection: get<_i3.IDatabaseConnection>(), log: get<_i8.ILogger>()));
  gh.lazySingleton<_i11.IPersonalTrainingService>(() =>
      _i12.PersonalTrainingService(
          personalTrainingRepository: get<_i9.IPersonalTrainingRepository>(),
          log: get<_i13.ILogger>()));
  gh.lazySingleton<_i14.IStudentRepository>(() => _i15.StudentRepository(
      connection: get<_i3.IDatabaseConnection>(), log: get<_i8.ILogger>()));
  gh.lazySingleton<_i16.IStudentService>(() => _i17.StudentService(
      studentRepository: get<_i14.IStudentRepository>(),
      log: get<_i8.ILogger>()));
  gh.factory<_i18.PersonalTrainingController>(() =>
      _i18.PersonalTrainingController(
          personalTrainingService: get<_i11.IPersonalTrainingService>(),
          log: get<_i8.ILogger>()));
  gh.factory<_i19.StudentController>(() => _i19.StudentController(
      studentService: get<_i16.IStudentService>(), log: get<_i8.ILogger>()));
  return get;
}
