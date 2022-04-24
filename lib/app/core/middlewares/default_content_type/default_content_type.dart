import 'package:shelf/shelf.dart';

class DefaultContentType {
  Middleware get middleware => createMiddleware(
        responseHandler: (Response res) {
          if (res.headers['content-type'] == null) {
            return res.change(
              headers: {
                'content-type': 'application/json',
              },
            );
          }
          return res;
        },
      );
}
