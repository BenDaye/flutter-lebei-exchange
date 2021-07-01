import '../utils/http/handler/types.dart';
import '../utils/http/main.dart';
import 'url/ccxt.dart';

class ApiCcxt {
  static Future<HttpResult<List<dynamic>>> exchanges() async {
    return http.request<List<dynamic>>(UrlCcxt.exchanges);
  }

  static Future<HttpResult<Map<String, dynamic>>> exchange(String exchangeId) async {
    return http.request<Map<String, dynamic>>(UrlCcxt.exchange(exchangeId));
  }

  static Future<HttpResult<int>> time(String exchangeId) async {
    return http.request<int>(UrlCcxt.time(exchangeId));
  }

  static Future<HttpResult<Map<String, dynamic>>> status(String exchangeId) async {
    return http.request<Map<String, dynamic>>(UrlCcxt.status(exchangeId));
  }

  static Future<HttpResult<Map<String, dynamic>>> market(String exchangeId, String symbol) async {
    return http.request<Map<String, dynamic>>(UrlCcxt.market(exchangeId, symbol));
  }

  static Future<HttpResult<Map<String, dynamic>>> markets(String exchangeId) async {
    return http.request<Map<String, dynamic>>(UrlCcxt.markets(exchangeId));
  }

  static Future<HttpResult<String>> marketId(String exchangeId, String symbol) async {
    return http.request<String>(UrlCcxt.marketId(exchangeId, symbol));
  }

  static Future<HttpResult<List<dynamic>>> marketIds(String exchangeId, List<String> symbols) async {
    final String _symbols = symbols.map((String symbol) => 'symbol=$symbol').toList().join('&');
    return http.request<List<dynamic>>(UrlCcxt.marketIds(exchangeId, _symbols));
  }

  static Future<HttpResult<String>> symbol(String exchangeId, String symbol) async {
    return http.request<String>(UrlCcxt.symbol(exchangeId, symbol));
  }

  static Future<HttpResult<List<dynamic>>> symbols(String exchangeId) async {
    return http.request<List<dynamic>>(UrlCcxt.symbols(exchangeId));
  }

  static Future<HttpResult<Map<String, dynamic>>> currencies(String exchangeId) async {
    return http.request<Map<String, dynamic>>(UrlCcxt.currencies(exchangeId));
  }

  static Future<HttpResult<List<dynamic>>> ids(String exchangeId) async {
    return http.request<List<dynamic>>(UrlCcxt.ids(exchangeId));
  }

  static Future<HttpResult<Map<String, dynamic>>> orderbook(String exchangeId, String symbol) async {
    return http.request<Map<String, dynamic>>(UrlCcxt.orderbook(exchangeId, symbol));
  }

  static Future<HttpResult<Map<String, dynamic>>> depth(String exchangeId, String symbol) async {
    return http.request<Map<String, dynamic>>(UrlCcxt.depth(exchangeId, symbol));
  }

  static Future<HttpResult<Map<String, dynamic>>> price(String exchangeId, String symbol) async {
    return http.request<Map<String, dynamic>>(UrlCcxt.price(exchangeId, symbol));
  }

  static Future<HttpResult<List<dynamic>>> ohlcv(String exchangeId, String symbol, {String period = '1m'}) async {
    return http.request<List<dynamic>>(UrlCcxt.ohlcv(exchangeId, symbol, period));
  }

  static Future<HttpResult<List<dynamic>>> trades(String exchangeId, String symbol) async {
    return http.request<List<dynamic>>(UrlCcxt.trades(exchangeId, symbol));
  }

  static Future<HttpResult<Map<String, dynamic>>> ticker(String exchangeId, String symbol,
      {Function(dynamic)? handleError}) async {
    return http.request<Map<String, dynamic>>(UrlCcxt.ticker(exchangeId, symbol), handleError: handleError);
  }

  static Future<HttpResult<Map<String, dynamic>>> tickers(String exchangeId, {List<String>? symbols}) async {
    final String? _symbols;
    if (symbols == null) {
      _symbols = null;
    } else {
      _symbols = symbols.map((String symbol) => 'symbol=$symbol').toList().join('&');
    }
    return http.request<Map<String, dynamic>>(UrlCcxt.tickers(exchangeId, _symbols));
  }
}
