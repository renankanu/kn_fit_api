import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:kn_fit_api/app/core/core.dart';
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
      return Response.ok(
          jsonEncode({'message': 'cadastro realizado com sucesso ${user.id}'}));
    } on EmailAlreadyRegistered {
      return Response(400,
          body: jsonEncode(
              {'message': 'Usuário já cadastrado na base de dados'}));
    } catch (e) {
      log.error('Erro ao cadastrar usuário', e);
      return Response.internalServerError();
    }
  }

  Router get router => _$AuthControllerRouter(this);
}
