import 'package:logger/logger.dart';

class TimerHandler {
  static common({String? name, Function? action}) {
    Logger logger = Logger(printer: PrettyPrinter(methodCount: 0, printEmojis: false));
    return (int tick) {
      logger.d('Timer ==> [NAME]: $name, [TICK]: $tick');
      if (action != null) action();
    };
  }
}
