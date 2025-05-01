import 'package:logger/logger.dart';

class LoggerMsg {
  static void showErrorLog({required String msg}) {
    var logger = Logger(
      printer: PrettyPrinter(
        noBoxingByDefault: true,
        methodCount: 2, // Number of method calls to be displayed
        errorMethodCount: 8, // Number of method calls if stacktrace is provided
        lineLength: 120, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        dateTimeFormat:
            DateTimeFormat.onlyTimeAndSinceStart, // Time-based log output
      ),
    );
    logger.w(msg);
  }


  static void showInfoLog({required String msg}) {
    var logger = Logger(
      printer: PrettyPrinter(
        noBoxingByDefault: true,
        methodCount: 2, // Number of method calls to be displayed
        errorMethodCount: 8, // Number of method calls if stacktrace is provided
        lineLength: 120, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        dateTimeFormat:
            DateTimeFormat.onlyTimeAndSinceStart, // Time-based log output
      ),
    );
    logger.i(msg);
  }
  
  static void showSuccessLog({required String msg}) {
    var logger = Logger(
      printer: PrettyPrinter(
        noBoxingByDefault: true,
        methodCount: 2, // Number of method calls to be displayed
        errorMethodCount: 8, // Number of method calls if stacktrace is provided
        lineLength: 120, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        dateTimeFormat:
            DateTimeFormat.onlyTimeAndSinceStart, // Time-based log output
      ),
    );
    logger.d(msg);
  }
}
