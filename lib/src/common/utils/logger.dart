import 'dart:developer' as developer;

void Function(Object? message) fine = _log("FINE", 500);

void Function(Object? message) info = _log("INFO", 800);

void Function(Object? message, [StackTrace? stackTrace]) shout = _log("SHOUT", 1200);

void Function(
  Object? message, [
  StackTrace? stackTrace,
]) _log(String prefix, int level) => (
      Object? message, [
      StackTrace? stackTrace,
    ]) {
      bool isDebugMode = false;
      assert(isDebugMode = true);
      if (!isDebugMode) return;

      developer.log(
        "[$prefix] $message",
        level: level,
        error: message is Error || message is Exception ? message : null,
        stackTrace: stackTrace,
      );
    };
