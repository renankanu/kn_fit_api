import 'package:shelf/shelf.dart';

class DefaultContentType {
  Middleware get middleware => createMiddleware(
        responseHandler: (Response res) {
          if (res.mimeType == 'text/html') {
            return res;
          }
          if (res.headers['content-type'] == null) {
            res = res.change(
              headers: {
                'content-type': 'application/json',
              },
            );
          }
          if (!res.headers['content-type']!.startsWith('image')) {
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
