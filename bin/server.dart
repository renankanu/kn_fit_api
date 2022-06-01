import 'dart:convert';

import 'package:dotenv/dotenv.dart';
import 'package:kn_fit_api/app/core/core.dart';
import 'package:kn_fit_api/app/infra/custom_server.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Future<void> main() async {
  load();

  final router = Router();
  router.get(
    '/health',
    (Request request) => Response.ok(
      jsonEncode({'up': 'true'}),
    ),
  );

  final appConfig = ApplicationConfig();
  await appConfig.loadConfigApplication(router);

  final handler = const Pipeline()
      .addMiddleware(CorsMiddlewares().handler)
      .addMiddleware(DefaultContentType().middleware)
      .addMiddleware(SecurityMiddleware(getIt.get()).handler)
      .addMiddleware(logRequests())
      .addHandler(router);

  await CustomServer.initialize(
    handler: handler,
    address: env['SERVER_ADDRESS'] ?? 'localhost',
    port: int.tryParse(env['SERVER_PORT']!) ?? 0,
  );
}
