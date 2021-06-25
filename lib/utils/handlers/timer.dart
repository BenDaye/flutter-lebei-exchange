import 'package:flustars/flustars.dart' show TimerUtil;
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TimerHandler {
  static Function(int) common({String? name, Function? action}) {
    final Logger logger = Logger(printer: PrettyPrinter(methodCount: 0, printEmojis: false));
    return (int tick) {
      logger.d('Timer ==> [NAME]: $name, [TICK]: $tick');
      if (action != null) action();
    };
  }

  static Function(double) watchAutoRefresh(TimerUtil timer) {
    return (double m) {
      if (timer.isActive()) timer.cancel();
      if (!m.isEqual(0)) {
        timer.setInterval(m.toInt() * 1000);
        timer.startTimer();
      }
    };
  }
}
