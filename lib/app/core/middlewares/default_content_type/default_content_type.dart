import 'package:shelf/shelf.dart';

class DefaultContentType {
  Middleware get middleware => createMiddleware(
        responseHandler: (Response res) => res.change(
          headers: {
            'content-type': 'application/json',
          },
        ),
      );
}
