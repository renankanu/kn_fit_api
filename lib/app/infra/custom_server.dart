import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

class CustomServer {
  CustomServer._();
  static Future<void> initialize({
    required Handler handler,
    required String address,
    required int port,
  }) async {
    final server = await io.serve(handler, address, port);
    print('Serving at http://${server.address.host}:${server.port}');
  }
}
