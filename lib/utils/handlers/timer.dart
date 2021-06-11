import 'package:flustars/flustars.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';

class TimerHandler {
  static common({String? name, Function? action}) {
    Logger logger = Logger(printer: PrettyPrinter(methodCount: 0, printEmojis: false));
    return (int tick) {
      logger.d('Timer ==> [NAME]: $name, [TICK]: $tick');
      if (action != null) action();
    };
  }

  static watchAutoRefresh(TimerUtil timer) {
    return (double m) {
      if (timer.isActive()) timer.cancel();
      if (!m.isEqual(0)) {
        timer.setInterval(m.toInt() * 1000);
        timer.startTimer();
      }
    };
  }
}
