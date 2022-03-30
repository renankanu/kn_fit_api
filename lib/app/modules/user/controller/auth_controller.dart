import 'dart:async';
import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dotenv/dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:kn_fit_api/app/core/core.dart';
import 'package:kn_fit_api/app/core/helpers/response_helper.dart';
import 'package:kn_fit_api/app/models/models.dart';
import 'package:kn_fit_api/app/modules/user/service/i_user_service.dart';
import 'package:kn_fit_api/app/modules/user/view_models/login_view_model.dart';
import 'package:kn_fit_api/app/modules/user/view_models/user_save_input_model.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:uuid/uuid.dart';

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

  @Route.post('/login')
  Future<Response> login(Request request) async {
    return ResponseHelper.load(
      action: () async {
        final loginViewModel = LoginViewModel(await request.readAsString());
        final user = await userService.login(
          loginViewModel.email,
          loginViewModel.password,
        );
        log.debug('user: ${user.toString()}');

        return Response.ok(
          jsonEncode(
            {
              'access_token': _generateJWT(),
            },
          ),
          headers: {'content-type': 'application/json'},
        );
      },
      log: log,
    );
  }

  String _generateJWT() {
    final jwt = JWT(
      {
        'iat': DateTime.now().millisecondsSinceEpoch,
        'user_id': '123123',
      },
      subject: 'kn_fit',
      issuer: 'https://www.renankanu.com.br',
      jwtId: Uuid().v4(),
    );

    final token = jwt.sign(
      SecretKey(env['JWT_SECRET']!),
      expiresIn: Duration(hours: 1),
      algorithm: JWTAlgorithm.HS256,
    );
    return 'Bearer' + token;
  }

  Router get router => _$AuthControllerRouter(this);
}
