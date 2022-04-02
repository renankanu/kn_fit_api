import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../../core/core.dart';
import '../../../core/helpers/jwt_helper.dart';
import '../../../core/helpers/response_helper.dart';
import '../../../models/models.dart';
import '../service/i_user_service.dart';
import '../view_models/login_view_model.dart';
import '../view_models/user_save_input_model.dart';

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
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        final body = await request.readAsString();
        final userModel = UserSaveInputModel.requestMapping(body);
        await userService.createUser(userModel);
        return ResponseHelper.baseResponse(
          201,
          responseModel: ResponseModel(
            data: null,
            message: 'Usuário criado com sucesso.',
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
        final user = await userService.login(
          loginViewModel.email,
          loginViewModel.password,
        );

        return Response.ok(
          JwtHelper.createTokenPair(user.id!).toString(),
        );
      },
      log: log,
    );
  }

  Router get router => _$AuthControllerRouter(this);
}
