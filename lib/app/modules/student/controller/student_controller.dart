import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../../core/core.dart';
import '../../../models/models.dart';
import '../service/i_student_service.dart';

part 'student_controller.g.dart';

@Injectable()
class StudentController {
  IStudentService studentService;
  ILogger log;

  StudentController({
    required this.studentService,
    required this.log,
  });

  @Route.post('/')
  Future<Response> saveStudent(Request request) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        final body = await request.readAsString();
        final studentModel = StudentModel.requestMapping(body);
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
        final loginViewModel =
            LoginModel.requestMapping(await request.readAsString());
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
              TokenType.student,
            ),
            message: 'Login realizado com sucesso.',
          ),
        );
      },
      log: log,
    );
  }

  @Route.get('/info')
  Future<Response> getStudentInfo(Request request) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        final userId = int.parse(request.headers['user']!);
        final tokenType =
            TokenTypeUtils.fromString(request.headers['referring_to']!);
        if (tokenType != TokenType.student) {
          return ResponseHelper.baseResponse(
            401,
            responseModel: ResponseModel(
              data: null,
              message: 'Token inválido.',
            ),
          );
        }
        final student = await studentService.getInfo(userId);
        return ResponseHelper.baseResponse(
          200,
          responseModel: ResponseModel(
            data: student.toJson(),
            message: 'Aluno recuperado com sucesso.',
          ),
        );
      },
      log: log,
    );
  }

  @Route.get('/')
  Future<Response> getAllStudents(Request request) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        if (request.requestedUri.queryParameters['email'] != null) {
          final student = await studentService.getInfoByEmail(
            request.requestedUri.queryParameters['email']!,
          );
          return ResponseHelper.baseResponse(
            200,
            responseModel: ResponseModel(
              data: student.toJson(),
              message: 'Alunos recuperados com sucesso.',
            ),
          );
        }
        final students = await studentService.getAll();
        return ResponseHelper.baseResponse(
          200,
          responseModel: ResponseModel(
            data: students.map((student) => student.toJson()).toList(),
            message: 'Alunos recuperados com sucesso.',
          ),
        );
      },
      log: log,
    );
  }

  @Route('PATCH', '/<id|[0-9]+>')
  Future<Response> updateStudent(Request request, String id) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        final json = jsonDecode(await request.readAsString());
        final localStudent = await studentService.getInfo(int.parse(id));
        final studentUpdated = localStudent.copyWithFromJson(json: json);
        await studentService.updateStudent(studentUpdated);
        return ResponseHelper.baseResponse(
          200,
          responseModel: ResponseModel(
            data: null,
            message: 'Aluno atualizado com sucesso.',
          ),
        );
      },
      log: log,
    );
  }

  @Route('DELETE', '/<id|[0-9]+>')
  Future<Response> deleteStudent(Request request, String id) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        await studentService.deleteStudent(int.parse(id));
        return ResponseHelper.baseResponse(
          200,
          responseModel: ResponseModel(message: 'Aluno removido com sucesso'),
        );
      },
      log: log,
    );
  }

  Router get router => _$StudentControllerRouter(this);
}
