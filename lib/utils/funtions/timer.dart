class TimerHandler {
  static common({String? name, Function? action}) {
    return (int tick) {
      print('Timer ==> [NAME]: $name, [TICK]: $tick');
      if (action != null) action();
    };
  }
}
