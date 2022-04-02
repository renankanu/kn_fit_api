import 'package:shelf/shelf.dart';

abstract class BaseMiddleware {
  late Handler innerHandler;

  Handler handler(Handler innerHandler) {
    this.innerHandler = innerHandler;
    return execute;
  }

  Future<Response> execute(Request request);
}
