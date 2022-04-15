import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../../core/core.dart';
import '../../../models/models.dart';
import '../../student/view_models/login_view_model.dart';
import '../service/i_personal_training_service.dart';
import '../view_models/personal_training_save_input.dart';

part 'personal_training_controller.g.dart';

@Injectable()
class PersonalTrainingController {
  PersonalTrainingController({
    required this.personalTrainingService,
    required this.log,
  });

  final IPersonalTrainingService personalTrainingService;
  final ILogger log;

  @Route.post('/register')
  Future<Response> savePersonalTraining(Request request) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        final body = await request.readAsString();
        final personalTraining = PersonalTrainingSaveInput.requestMapping(body);
        await personalTrainingService.createPersonalTraining(personalTraining);
        return ResponseHelper.baseResponse(
          201,
          responseModel: ResponseModel(
            data: null,
            message: 'Personal Training criado com sucesso.',
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
        final personalTraining = await personalTrainingService.login(
          loginViewModel.email,
          loginViewModel.password,
        );
        return ResponseHelper.baseResponse(
          200,
          responseModel: ResponseModel(
            data: JwtHelper.createTokenPair(
              personalTraining.id!,
              personalTraining.email,
              personalTraining.fullName,
              TokenType.personalTraining,
            ),
            message: 'Login realizado com sucesso.',
          ),
        );
      },
      log: log,
    );
  }

  @Route.get('/')
  Future<Response> getAllPersonalTrainings(Request request) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        final personalTrainings = await personalTrainingService.getAll();
        final encodeJsonPersonalTraining = jsonEncode(personalTrainings);
        return ResponseHelper.baseResponse(
          200,
          responseModel: ResponseModel(
            data: jsonDecode(encodeJsonPersonalTraining),
            message: 'Personal Trainings recuperados com sucesso.',
          ),
        );
      },
      log: log,
    );
  }

  @Route.get('/info')
  Future<Response> getPersonalTrainingInfo(Request request) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        final id = int.parse(request.headers['user']!);
        final tokenType =
            TokenTypeUtils.fromString(request.headers['referring_to']!);
        if (tokenType != TokenType.personalTraining) {
          return ResponseHelper.baseResponse(
            401,
            responseModel: ResponseModel(
              data: null,
              message: 'Token inválido.',
            ),
          );
        }
        final personalTraining = await personalTrainingService.getInfo(id);
        final encodeJsonPersonalTraining = jsonEncode(personalTraining);
        return ResponseHelper.baseResponse(
          200,
          responseModel: ResponseModel(
            data: jsonDecode(encodeJsonPersonalTraining),
            message: 'Personal Training recuperado com sucesso.',
          ),
        );
      },
      log: log,
    );
  }

  Router get router => _$PersonalTrainingControllerRouter(this);
}
