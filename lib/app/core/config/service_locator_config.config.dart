// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../modules/student/controller/student_controller.dart' as _i11;
import '../../modules/student/repository/i_user_repository.dart' as _i6;
import '../../modules/student/repository/user_repository.dart' as _i7;
import '../../modules/student/service/i_user_service.dart' as _i9;
import '../../modules/student/service/user_service.dart' as _i10;
import '../core.dart' as _i8;
import '../database/database.dart' as _i4;
import '../database/i_database_connection.dart' as _i3;
import 'config.dart' as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.IDatabaseConnection>(
      () => _i4.Database(get<_i5.DatabaseConnectionConfiguration>()));
  gh.lazySingleton<_i6.IStudentRepository>(() => _i7.UserRepository(
      connection: get<_i3.IDatabaseConnection>(), log: get<_i8.ILogger>()));
  gh.lazySingleton<_i9.IStudentService>(() => _i10.UserService(
      userRepository: get<_i6.IStudentRepository>(), log: get<_i8.ILogger>()));
  gh.factory<_i11.StudentController>(() => _i11.StudentController(
      studentService: get<_i9.IStudentService>(), log: get<_i8.ILogger>()));
  return get;
}
