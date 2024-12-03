import 'dart:developer';
import 'package:flutter/foundation.dart';

// Log levels:
// https://github.com/pinojs/pino/issues/123
// https://logging.apache.org/log4j/2.x/manual/customloglevels.html

class Logger {
  Logger() {
    logLevel = kDebugMode ? 100 : 700;
  }
  late int logLevel;

  // fatal
  void f(String message, Object error, StackTrace? stack) {
    _log(message, 100, error, stack);
  }

  // error
  void e(String message, Object error, StackTrace? stack) {
    _log(message, 200, error, stack);
  }

  // warning
  void w(String message, Object? error, StackTrace? stack) {
    _log(message, 300, error, stack);
  }

  // information
  void i(String message) {
    _log(message, 400);
  }

  // debug
  void d(String message) {
    _log(message, 500);
  }

  void _log(String message, int level, [Object? error, StackTrace? stack]) {
    if (level >= logLevel) {
      log(message, level: level, error: error, stackTrace: stack);
    }
  }
}

final logger = Logger();
