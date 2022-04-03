import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../../core/core.dart';
import '../../../models/models.dart';
import '../service/i_student_service.dart';
import '../view_models/login_view_model.dart';
import '../view_models/student_save_input_model.dart';

part 'student_controller.g.dart';

@Injectable()
class StudentController {
  IStudentService studentService;
  ILogger log;

  StudentController({
    required this.studentService,
    required this.log,
  });

  @Route.post('/register')
  Future<Response> saveStudent(Request request) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        final body = await request.readAsString();
        final studentModel = StudentSaveInputModel.requestMapping(body);
        await studentService.createStudent(studentModel);
        return ResponseHelper.baseResponse(
          201,
          responseModel: ResponseModel(
            data: null,
            message: 'Aluno criado com sucesso.',
          ),
        );
      },
      log: log,
    );
  }

  @Route.post('/login')
  Future<Response> login(Request request) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        final loginViewModel = LoginViewModel(await request.readAsString());
        final student = await studentService.login(
          loginViewModel.email,
          loginViewModel.password,
        );
        return ResponseHelper.baseResponse(
          200,
          responseModel: ResponseModel(
            data: JwtHelper.createTokenPair(
              student.id!,
              student.email,
              student.fullName,
              'student',
            ),
            message: 'Login realizado com sucesso.',
          ),
        );
      },
      log: log,
    );
  }

  Router get router => _$StudentControllerRouter(this);
}
