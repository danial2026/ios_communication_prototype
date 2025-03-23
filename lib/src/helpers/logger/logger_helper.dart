import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:logger/logger.dart' as logger;
import 'package:loggy/loggy.dart' hide PrettyPrinter;

// ignore: avoid_classes_with_only_static_members
class LoggerHelper with UiLoggy {
  static final logger.Logger _logger = logger.Logger(
    printer: logger.PrettyPrinter(
      methodCount: 0, // number of method calls to be displayed
      errorMethodCount: 5, // number of method calls if stacktrace is provided
      lineLength: 50, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      dateTimeFormat: logger.DateTimeFormat.onlyTimeAndSinceStart, // format date
    ),
    output: null,
    filter: null,
  );

  static void initLoggy() {
    Loggy.initLoggy(
      logPrinter: _CustomLoggyPrinter(),
    );
  }

  static void debugLog(String message) {
    logDebug(message);
  }

  static void wtfLog(String message) {
    _logger.f(message);
  }

  static void errorLog(String message) {
    logError(message);
  }

  static _ColorfulLogger colorfulLogger = _ColorfulLogger();
}

class _CustomLoggyPrinter extends LoggyPrinter {
  static final Map<LogLevel, String> _levelPrefixes = <LogLevel, String>{
    LogLevel.debug: '🐛 ',
    LogLevel.info: '👻 ',
    LogLevel.warning: '⚠️ ',
    LogLevel.error: '‼️ ',
  };

  // For undefined log levels
  static const String _defaultPrefix = '🤔 ';

  @override
  void onLog(LogRecord record) {
    final String _prefix = levelPrefix(record.level) ?? _defaultPrefix;

    developer.log(
      '$_prefix ${record.message}',
      name: record.loggerName,
      error: record.error,
      stackTrace: record.stackTrace,
      level: record.level.priority,
      zone: record.zone,
      sequenceNumber: record.sequenceNumber,
    );
  }

  /// Get prefix for level
  String? levelPrefix(LogLevel level) {
    return _levelPrefixes[level];
  }
}

class _ColorfulLogger {
  /// printWarning
  void printWarning(String text) {
    _log('${_LogColor.yellow}$text\x1B[0m');
  }

  /// printError
  void printError(String text) {
    _log('${_LogColor.red}$text\x1B[0m');
  }

  /// printSuccess
  void printSuccess(String text) {
    _log('${_LogColor.green}$text\x1B[0m');
  }

  /// printCustom
  void printCustom(String text, {String color = _LogColor.white}) {
    _log('$color$text\x1B[0m');
  }

  void _log(String s) {
    developer.log(s);
  }
}

class _LogColor {
  static const String black = '\x1B[30m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String magenta = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';
}

extension ColorfulPrint on String {
  VoidCallback get printError => () => LoggerHelper.colorfulLogger.printError(this);
  VoidCallback get printSuccess => () => LoggerHelper.colorfulLogger.printSuccess(this);
  VoidCallback get printWarning => () => LoggerHelper.colorfulLogger.printWarning(this);

  VoidCallback get printInBlack => () => LoggerHelper.colorfulLogger.printCustom(this, color: _LogColor.black);
  VoidCallback get printInBlue => () => LoggerHelper.colorfulLogger.printCustom(this, color: _LogColor.blue);
  VoidCallback get printInMagenta => () => LoggerHelper.colorfulLogger.printCustom(this, color: _LogColor.magenta);
  VoidCallback get printInCyan => () => LoggerHelper.colorfulLogger.printCustom(this, color: _LogColor.cyan);
  VoidCallback get printInYellow => () => LoggerHelper.colorfulLogger.printCustom(this, color: _LogColor.yellow);
}
