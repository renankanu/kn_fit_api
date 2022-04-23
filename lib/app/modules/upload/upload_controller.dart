import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_multipart/multipart.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/core.dart';
import '../../infra/upload_image.dart';
import '../../models/response_model.dart';

part 'upload_controller.g.dart';

@Injectable()
class UploadController {
  ILogger log;

  UploadController({
    required this.log,
  });

  @Route.post('/')
  Future<Response> uploadAvatar(Request request) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        if (!request.isMultipart) {
          return ResponseHelper.baseResponse(
            400,
            responseModel: ResponseModel(
              message: 'Requisição inválida.',
            ),
          );
        }
        final nameImage = DateTime.now().millisecondsSinceEpoch.toString();
        const imageExt = 'jpg';
        await for (final part in request.parts) {
          final imageExt = part.headers['content-type']!.split('/').last;
          final data = await part.readBytes();
          await UploadImage.sendImageToS3(
            data,
            imageName: nameImage,
            imageExt: imageExt,
          );
        }
        return ResponseHelper.baseResponse(
          201,
          responseModel: ResponseModel(
            data: '$nameImage.$imageExt',
            message: 'Upload da imagem realizado com sucesso.',
          ),
        );
      },
      log: log,
    );
  }

  @Route.get('/')
  Future<Response> getAvatar(Request request) async {
    final image = await UploadImage.getObjectFromS3();
    return Response(
      200,
      body: image,
      headers: {
        'content-type': 'image/jpeg',
      },
    );
  }

  Router get router => _$UploadControllerRouter(this);
}
