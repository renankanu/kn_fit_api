import 'dart:async';
import 'dart:convert';

import 'package:kn_fit_api/app/core/exceptions/exceptions.dart';
import 'package:kn_fit_api/app/models/models.dart';
import 'package:kn_fit_api/app/repositories/user_repository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'auth_controller.g.dart';

class AuthController {
  final _userRepository = UserRepository();

  @Route.post('/register')
  Future<Response> find(Request request) async {
    try {
      final userRequest = UserModel.fromJson(await request.readAsString());
      _userRepository.save(userRequest);
      return Response.ok(json.encode(userRequest));
    } on EmailAlreadyRegistered catch (e, s) {
      print(e);
      print(s);
      return Response(
        400,
        body: {
          jsonEncode(
            {
              'error': e.toString(),
            },
          )
        },
        headers: {
          'Content-Type': 'application/json',
        },
      );
    }
  }

  Router get router => _$AuthControllerRouter(this);
}
