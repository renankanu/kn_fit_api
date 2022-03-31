import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:kn_fit_api/app/core/exceptions/required_field_exception.dart';
import 'package:kn_fit_api/app/models/models.dart';
import 'package:shelf/shelf.dart';

import '../core.dart';

class ResponseHelper {
  ResponseHelper._();

  static Future<Response> makeResponse({
    required Future<Response> Function() handlerResponse,
    required ILogger log,
  }) async {
    try {
      return await handlerResponse();
    } on EmailAlreadyRegistered {
      return Response(
        400,
        body: ResponseModel(
          data: null,
          message: 'Email já cadastrado.',
        ).toString(),
        headers: {'content-type': 'application/json'},
      );
    } on RequiredFieldException catch (e, _) {
      return Response(
        400,
        body: ResponseModel(
          data: null,
          message: e.toString(),
        ).toString(),
        headers: {'content-type': 'application/json'},
      );
    } on UserNotFoundException catch (e, _) {
      return Response(
        400,
        body: ResponseModel(
          data: null,
          message: e.toString(),
        ).toString(),
        headers: {'content-type': 'application/json'},
      );
    } on FormatException catch (e, _) {
      return Response(
        400,
        body: ResponseModel(
          data: null,
          message: 'Formato do json inválido.',
        ).toString(),
        headers: {'content-type': 'application/json'},
      );
    } on JWTError catch (e, _) {
      return Response(
        403,
        body: ResponseModel(
          data: null,
          message: e.toString(),
        ).toString(),
        headers: {'content-type': 'application/json'},
      );
    } catch (error) {
      log.error('Erro ao cadastrar usuário', error);
      return Response.internalServerError();
    }
  }
}
