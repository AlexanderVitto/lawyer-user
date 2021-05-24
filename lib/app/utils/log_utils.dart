import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogUtils {
  Logger _logger;
  String _fileName;
  bool _isEnabled;

  LogUtils({@required String fileName, bool isEnable = false}) {
    _logger = Logger(
      printer: PrettyPrinter(
          methodCount: 0, colors: true, printEmojis: true, printTime: true),
    );
    _fileName = fileName;
    _isEnabled = isEnable;
  }

  debug({String method = '', String message = ''}) {
    if (_isEnabled) _logger.d('File [$_fileName] Method [$method] $message');
  }

  info({String method = '', String message = ''}) {
    if (_isEnabled) _logger.i('File [$_fileName] Method [$method] $message');
  }

  warning({String method = '', String message = ''}) {
    if (_isEnabled) _logger.w('File [$_fileName] Method [$method] $message');
  }

  error({String method = '', String message = ''}) {
    if (_isEnabled) _logger.e('File [$_fileName] Method [$method] $message');
  }
}
