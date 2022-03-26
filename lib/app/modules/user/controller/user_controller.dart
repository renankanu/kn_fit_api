import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'user_controller.g.dart';

@Injectable()
class UserController {
  @Route.post('/')
  Future<Response> login(Request request) async {
    return Response.ok(jsonEncode({'message': 'login realizado com sucesso'}));
  }

  Router get router => _$UserControllerRouter(this);
}
