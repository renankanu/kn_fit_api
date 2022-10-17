import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../../core/core.dart';
import '../../../models/models.dart';
import '../service/i_exercise_service.dart';

part 'exercise_controller.g.dart';

@Injectable()
class ExerciseController {
  final IExerciseService exerciseService;
  final ILogger log;

  ExerciseController({
    required this.exerciseService,
    required this.log,
  });

  @Route.post('/')
  Future<Response> saveExercise(Request request) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        final tokenType =
            TokenTypeUtils.fromString(request.headers['referring_to']!);
        if (tokenType == TokenType.student) {
          return ResponseHelper.baseResponse(
            403,
            responseModel: ResponseModel(
              data: null,
              message: 'Acesso negado.',
            ),
          );
        }
        final body = await request.readAsString();
        final exercise = ExerciseModel.requestMapping(body);
        await exerciseService.createExercise(exercise);
        return ResponseHelper.baseResponse(
          201,
          responseModel: ResponseModel(
            data: null,
            message: 'Exercício criado com sucesso.',
          ),
        );
      },
      log: log,
    );
  }

  @Route.get('/')
  Future<Response> getAll(Request request) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        final exercises = await exerciseService.getAll();
        return ResponseHelper.baseResponse(
          200,
          responseModel: ResponseModel(
            data: exercises,
            message: 'Exercícios retornados com sucesso.',
          ),
        );
      },
      log: log,
    );
  }

  @Route.get('/<id|[0-9]+>')
  Future<Response> getDetail(Request request, String id) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        final exercise = await exerciseService.getDetail(int.parse(id));
        return ResponseHelper.baseResponse(
          200,
          responseModel: ResponseModel(
            data: exercise,
            message: 'Exercício retornado com sucesso.',
          ),
        );
      },
      log: log,
    );
  }

  Router get router => _$ExerciseControllerRouter(this);
}
