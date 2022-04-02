import 'package:logger/logger.dart' as log;

import './i_logger.dart';

class Logger implements ILogger {
  late dynamic _logger;

  Logger() {
    var release = true;
    assert(
      () {
        release = false;
        return true;
      }(),
    );
    _logger = log.Logger(
      filter: release ? log.ProductionFilter() : log.DevelopmentFilter(),
    );
  }

  @override
  void debug(message, [error, StackTrace? stackTrace]) =>
      _logger.d(message, error, stackTrace);

  @override
  void error(message, [error, StackTrace? stackTrace]) =>
      _logger.e(message, error, stackTrace);

  @override
  void info(message, [error, StackTrace? stackTrace]) =>
      _logger.i(message, error, stackTrace);

  @override
  void warning(message, [error, StackTrace? stackTrace]) =>
      _logger.w(message, error, stackTrace);
}
