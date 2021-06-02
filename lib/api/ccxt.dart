import 'package:flutter_lebei_exchange/api/url/ccxt.dart';
import 'package:flutter_lebei_exchange/utils/http/handler/types.dart';
import 'package:flutter_lebei_exchange/utils/http/main.dart';

class ApiCcxt {
  static Future<HttpResult<List>> exchanges() async {
    return await http.request<List>(UrlCcxt.exchanges);
  }

  static Future<HttpResult<int>> time(String exchangeId) async {
    return await http.request<int>(UrlCcxt.time(exchangeId));
  }

  static Future<HttpResult<Map<String, dynamic>>> status(String exchangeId) async {
    return await http.request<Map<String, dynamic>>(UrlCcxt.status(exchangeId));
  }

  static Future<HttpResult<Map<String, dynamic>>> market(String exchangeId, String symbol) async {
    return await http.request<Map<String, dynamic>>(UrlCcxt.market(exchangeId, symbol));
  }

  static Future<HttpResult<Map<String, dynamic>>> markets(String exchangeId) async {
    return await http.request<Map<String, dynamic>>(UrlCcxt.markets(exchangeId));
  }

  static Future<HttpResult<String>> marketId(String exchangeId, String symbol) async {
    return await http.request<String>(UrlCcxt.marketId(exchangeId, symbol));
  }

  static Future<HttpResult<List>> marketIds(String exchangeId, List<String> symbols) async {
    String _symbols = symbols.map((symbol) => 'symbol=$symbol').toList().join('&');
    return await http.request<List>(UrlCcxt.marketIds(exchangeId, _symbols));
  }

  static Future<HttpResult<String>> symbol(String exchangeId, String symbol) async {
    return await http.request<String>(UrlCcxt.symbol(exchangeId, symbol));
  }

  static Future<HttpResult<List>> symbols(String exchangeId) async {
    return await http.request<List>(UrlCcxt.symbols(exchangeId));
  }

  static Future<HttpResult<Map<String, dynamic>>> currencies(String exchangeId) async {
    return await http.request<Map<String, dynamic>>(UrlCcxt.currencies(exchangeId));
  }

  static Future<HttpResult<List>> ids(String exchangeId) async {
    return await http.request<List>(UrlCcxt.ids(exchangeId));
  }

  static Future<HttpResult<Map<String, dynamic>>> orders(String exchangeId, String symbol) async {
    return await http.request<Map<String, dynamic>>(UrlCcxt.orders(exchangeId, symbol));
  }

  static Future<HttpResult<Map<String, dynamic>>> depth(String exchangeId, String symbol) async {
    return await http.request<Map<String, dynamic>>(UrlCcxt.depth(exchangeId, symbol));
  }

  static Future<HttpResult<Map<String, dynamic>>> price(String exchangeId, String symbol) async {
    return await http.request<Map<String, dynamic>>(UrlCcxt.price(exchangeId, symbol));
  }

  static Future<HttpResult<List>> ohlcv(String exchangeId, String symbol, {String period = '1m'}) async {
    return await http.request<List>(UrlCcxt.ohlcv(exchangeId, symbol, period));
  }

  static Future<HttpResult<List>> trades(String exchangeId, String symbol) async {
    return await http.request<List>(UrlCcxt.trades(exchangeId, symbol));
  }

  static Future<HttpResult<Map<String, dynamic>>> ticker(String exchangeId, String symbol,
      {Function(dynamic)? handleError}) async {
    return await http.request<Map<String, dynamic>>(UrlCcxt.ticker(exchangeId, symbol), handleError: handleError);
  }

  static Future<HttpResult<Map<String, dynamic>>> tickers(String exchangeId, {List<String>? symbols}) async {
    String? _symbols = symbols == null ? null : symbols.map((symbol) => 'symbol=$symbol').toList().join('&');
    return await http.request<Map<String, dynamic>>(UrlCcxt.tickers(exchangeId, _symbols));
  }
}
