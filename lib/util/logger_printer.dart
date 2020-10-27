import 'package:logger/logger.dart';

// top level function to get the logger with custom printer
Logger getLogger(String className) {
  //return Logger(printer: SimpleLogPrinter(className));
  return Logger(printer: SimplePrettyPrinter(className));
  //return Logger(printer: PrettyPrinter());
}

class SimplePrettyPrinter extends LogPrinter {
  final String className;

  SimplePrettyPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    // colour for log according level
    AnsiColor colour = PrettyPrinter.levelColors[event.level];
    // emoji for log according to level
    String emoji = PrettyPrinter.levelEmojis[event.level];
    String format = colour('$emoji $className - ${event.message}');
    return [format];
  }
}
