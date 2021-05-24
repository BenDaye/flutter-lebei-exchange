class UrlCcxt {
  static const String prefix = '/ccxt';

  static const String exchanges = '$prefix/exchanges';

  static String time(String exchangeId) => '$prefix/$exchangeId/time';
  static String status(String exchangeId) => '$prefix/$exchangeId/status';

  static String market(String exchangeId, String symbol) => '$prefix/$exchangeId/market/$symbol';
  static String markets(String exchangeId) => '$prefix/$exchangeId/markets';
  static String marketId(String exchangeId, String symbol) => '$prefix/$exchangeId/market_id/$symbol';
  static String marketIds(String exchangeId, String symbols) => '$prefix/$exchangeId/market_ids?$symbols';

  static String symbol(String exchangeId, String symbol) => '$prefix/$exchangeId/symbol/$symbol';
  static String symbols(String exchangeId) => '$prefix/$exchangeId/symbols';

  static String currencies(String exchangeId) => '$prefix/$exchangeId/currencies';

  static String ids(String exchangeId) => '$prefix/$exchangeId/ids';

  static String orders(String exchangeId, String symbol) => '$prefix/$exchangeId/orders/$symbol';
  static String depth(String exchangeId, String symbol) => '$prefix/$exchangeId/depth/$symbol';
  static String price(String exchangeId, String symbol) => '$prefix/$exchangeId/price/$symbol';

  static String ohlcv(String exchangeId, String symbol, String period) =>
      '$prefix/$exchangeId/ohlcv/$symbol?period=$period';

  static String trades(String exchangeId, String symbol) => '$prefix/$exchangeId/trades/$symbol';

  static String ticker(String exchangeId, String symbol) => '$prefix/$exchangeId/ticker/$symbol';
  static String tickers(String exchangeId, String? symbols) =>
      symbols == null ? '$prefix/$exchangeId/tickers' : '$prefix/$exchangeId/tickers?$symbols';
}
