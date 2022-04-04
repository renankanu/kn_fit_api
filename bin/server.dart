import 'dart:convert';

import 'package:dotenv/dotenv.dart';
import 'package:kn_fit_api/app/core/config/application_config.dart';
import 'package:kn_fit_api/app/core/config/service_locator_config.dart';
import 'package:kn_fit_api/app/core/middlewares/cors/cors_middlewares.dart';
import 'package:kn_fit_api/app/core/middlewares/default_content_type/default_content_type.dart';
import 'package:kn_fit_api/app/core/middlewares/security/security_middleware.dart';
import 'package:kn_fit_api/app/infra/custom_server.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_router/shelf_router.dart';

Future<void> main() async {
  load();

  final router = Router();
  router.get(
    '/health',
    (shelf.Request request) => shelf.Response.ok(
      jsonEncode({'up': 'true'}),
    ),
  );

  final appConfig = ApplicationConfig();
  await appConfig.loadConfigApplication(router);

  final handler = const shelf.Pipeline()
      .addMiddleware(CorsMiddlewares().handler)
      .addMiddleware(DefaultContentType().middleware)
      .addMiddleware(SecurityMiddleware(getIt.get()).handler)
      .addMiddleware(shelf.logRequests())
      .addHandler(router);

  await CustomServer.initialize(
    handler: handler,
    address: env['SERVER_ADDRESS'] ?? 'localhost',
    port: int.tryParse(env['SERVER_PORT']!) ?? 0,
  );
}
