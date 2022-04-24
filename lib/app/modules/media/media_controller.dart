import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_multipart/multipart.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/core.dart';
import '../../infra/upload_image.dart';
import '../../models/response_model.dart';

part 'media_controller.g.dart';

@Injectable()
class MediaController {
  ILogger log;

  MediaController({
    required this.log,
  });

  @Route.post('/image/upload')
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
        String imageExt = 'jpeg';
        await for (final part in request.parts) {
          imageExt = part.headers['content-type']!.split('/').last;
          print(imageExt);
          final data = await part.readBytes();
          await MediaHelper.sendImageToS3(
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

  @Route.get('/image/<image>')
  Future<Response> getAvatar(Request request, String image) async {
    return ResponseHelper.makeResponse(
      handlerResponse: () async {
        final s3Object = await MediaHelper.getObjectFromS3(image);
        return Response.ok(
          s3Object,
          headers: {
            'content-type': 'image/${image.split('.').last}',
          },
        );
      },
      log: log,
    );
  }

  Router get router => _$MediaControllerRouter(this);
}
