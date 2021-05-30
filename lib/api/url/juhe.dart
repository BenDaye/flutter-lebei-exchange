class UrlJuhe {
  static const String prefix = '/juhe';

  static const String exchangePrefix = '$prefix/exchange';

  static const String exchangeQuery = '$exchangePrefix/query';

  static const String exchangeList = '$exchangePrefix/list';

  static String exchangeCurrency(String from, String to) => '$exchangePrefix/currency?from=$from&to=$to';
}
