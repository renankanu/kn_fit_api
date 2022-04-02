// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/personal_training/controller/personal_training_controller.dart'
    as _i16;
import '../../modules/personal_training/repository/i_personal_training_repository.dart'
    as _i6;
import '../../modules/personal_training/repository/personal_training_repository.dart'
    as _i7;
import '../../modules/personal_training/service/i_personal_training_service.dart'
    as _i9;
import '../../modules/personal_training/service/personal_training_service.dart'
    as _i10;
import '../../modules/student/controller/student_controller.dart' as _i17;
import '../../modules/student/repository/i_student_repository.dart' as _i12;
import '../../modules/student/repository/student_repository.dart' as _i13;
import '../../modules/student/service/i_student_service.dart' as _i14;
import '../../modules/student/service/student_service.dart' as _i15;
import '../core.dart' as _i8;
import '../database/database.dart' as _i4;
import '../database/i_database_connection.dart' as _i3;
import '../logger/i_logger.dart' as _i11;
import 'config.dart' as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.IDatabaseConnection>(
      () => _i4.Database(get<_i5.DatabaseConnectionConfiguration>()));
  gh.lazySingleton<_i6.IPersonalTrainingRepository>(() =>
      _i7.PersonalTrainingRepository(
          connection: get<_i3.IDatabaseConnection>(), log: get<_i8.ILogger>()));
  gh.lazySingleton<_i9.IPersonalTrainingService>(() =>
      _i10.PersonalTrainingService(
          personalTrainingRepository: get<_i6.IPersonalTrainingRepository>(),
          log: get<_i11.ILogger>()));
  gh.lazySingleton<_i12.IStudentRepository>(() => _i13.StudentRepository(
      connection: get<_i3.IDatabaseConnection>(), log: get<_i8.ILogger>()));
  gh.lazySingleton<_i14.IStudentService>(() => _i15.StudentService(
      studentRepository: get<_i12.IStudentRepository>(),
      log: get<_i8.ILogger>()));
  gh.factory<_i16.PersonalTrainingController>(() =>
      _i16.PersonalTrainingController(
          personalTrainingService: get<_i9.IPersonalTrainingService>(),
          log: get<_i8.ILogger>()));
  gh.factory<_i17.StudentController>(() => _i17.StudentController(
      studentService: get<_i14.IStudentService>(), log: get<_i8.ILogger>()));
  return get;
}
