import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart';

part 'documentation_controller.g.dart';

@Injectable()
class DocumentationController {
  DocumentationController();

  @Route.get('/<ignored|.*>')
  Future<Response> swaggerDoc(Request request) async {
    const path = 'specs/swagger.yaml';
    final handlerSwagger = SwaggerUI(
      path,
      title: '',
      deepLink: true,
    );
    return handlerSwagger(request);
  }

  Router get router => _$DocumentationControllerRouter(this);
}
