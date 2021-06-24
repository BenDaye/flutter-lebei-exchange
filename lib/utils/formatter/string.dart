class StringFormatter {
  static const String unknownString = '<unknown>';

  static String anyToString(dynamic value) {
    final dynamic _value = value ?? StringFormatter.unknownString;
    return _value.toString();
  }
}
