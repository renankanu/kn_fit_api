import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:dotenv/dotenv.dart';
import 'package:kn_fit_api/app/core/config/application_config.dart';
import 'package:kn_fit_api/app/core/config/service_locator_config.dart';
import 'package:kn_fit_api/app/core/middlewares/security/security_middleware.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

const _hostname = 'localhost';
void main(List<String> args) async {
  var parser = ArgParser()..addOption('port', abbr: 'p');
  var result = parser.parse(args);

  load();

  var portStr = result['port'] ?? Platform.environment['PORT'] ?? '8080';
  var port = int.tryParse(portStr);

  if (port == null) {
    stdout.writeln('Could not parse port value "$portStr" into a number.');
    exitCode = 64;
    return;
  }

  final router = Router();
  router.get(
    '/health',
    (shelf.Request request) => shelf.Response.ok(
      jsonEncode({'up': 'true'}),
      headers: {'content-type': 'application/json'},
    ),
  );

  final appConfig = ApplicationConfig();
  await appConfig.loadConfigApplication(router);

  var handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addMiddleware(SecurityMiddleware(getIt.get()).handler)
      .addHandler(router);

  var server = await io.serve(handler, _hostname, port);
  print('Serving at http://${server.address.host}:${server.port}');
}
