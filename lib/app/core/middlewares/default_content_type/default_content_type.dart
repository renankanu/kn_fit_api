import 'package:shelf/shelf.dart';

import '../base_middleware.dart';

class DefaultContentType extends BaseMiddleware {
  final String contentType;

  DefaultContentType(this.contentType);

  @override
  Future<Response> execute(Request request) async {
    final response = await innerHandler(request);
    return response.change(headers: {'content-type': contentType});
  }
}
