import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:kn_fit_api/app/core/core.dart';
import 'package:kn_fit_api/app/core/helpers/response_helper.dart';
import 'package:kn_fit_api/app/models/models.dart';
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
    return ResponseHelper.load(
      action: () async {
        final body = await request.readAsString();
        final userModel = UserSaveInputModel.requestMapping(body);
        await userService.createUser(userModel);
        return Response(
          201,
          body: ResponseModel(
            data: null,
            message: 'Usuário criado com sucesso.',
          ).toString(),
          headers: {'content-type': 'application/json'},
        );
      },
      log: log,
    );
  }

  Router get router => _$AuthControllerRouter(this);
}
