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
      );
    } on RequiredFieldException catch (e, _) {
      return ResponseHelper.baseResponse(
        400,
        responseModel: ResponseModel(
          data: null,
          message: e.toString(),
        ),
      );
    } on UserNotFoundException catch (e, _) {
      return ResponseHelper.baseResponse(
        400,
        responseModel: ResponseModel(
          data: null,
          message: e.toString(),
        ),
      );
    } on FormatException catch (e, _) {
      return ResponseHelper.baseResponse(
        400,
        responseModel: ResponseModel(
          data: null,
          message: e.toString(),
        ),
      );
    } catch (error) {
      log.error('Erro ao cadastrar usuário', error);
      return Response.internalServerError();
    }
  }

  static Response baseResponse(
    int status, {
    required ResponseModel responseModel,
  }) {
    return Response(
      status,
      body: responseModel.toString(),
    );
  }
}
