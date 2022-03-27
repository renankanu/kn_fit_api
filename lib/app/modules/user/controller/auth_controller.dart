import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:kn_fit_api/app/core/core.dart';
import 'package:kn_fit_api/app/models/response_model.dart';
import 'package:kn_fit_api/app/modules/user/service/i_user_service.dart';
import 'package:kn_fit_api/app/modules/user/view_models/user_save_input_model.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'auth_controller.g.dart';

@Injectable()
class AuthController {
  IUserService userService;
  ILogger log;

  AuthController({
    required this.userService,
    required this.log,
  });

  @Route.post('/register')
  Future<Response> saveUser(Request request) async {
    try {
      final body = await request.readAsString();
      final userModel = UserSaveInputModel.requestMapping(body);
      final user = await userService.createUser(userModel);
      return Response(
        201,
        body: ResponseModel(
          status: 201,
          data: user,
          internalMessage: '',
          message: 'Usuário criado com sucesso.',
        ).toJson(),
        headers: {'content-type': 'application/json'},
      );
    } on EmailAlreadyRegistered catch (error) {
      return Response(
        400,
        body: ResponseModel(
          status: 400,
          data: null,
          internalMessage: error.toString(),
          message: 'Email já cadastrado.',
        ).toJson(),
        headers: {'content-type': 'application/json'},
      );
    } catch (error) {
      log.error('Erro ao cadastrar usuário', error);
      return Response.internalServerError();
    }
  }

  Router get router => _$AuthControllerRouter(this);
}
