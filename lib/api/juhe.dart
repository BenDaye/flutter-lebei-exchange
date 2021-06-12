import 'package:flutter_lebei_exchange/api/url/juhe.dart';
import 'package:flutter_lebei_exchange/utils/http/handler/types.dart';
import 'package:flutter_lebei_exchange/utils/http/main.dart';

class ApiJuhe {
  static Future<HttpResult<List<dynamic>>> exchangeQuery() async {
    return http.request<List<dynamic>>(UrlJuhe.exchangeQuery);
  }

  static Future<HttpResult<List<dynamic>>> exchangeList() async {
    return http.request<List<dynamic>>(UrlJuhe.exchangeList);
  }

  static Future<HttpResult<List<dynamic>>> exchangeCurrency(String from, String to) async {
    return http.request<List<dynamic>>(UrlJuhe.exchangeCurrency(from, to));
  }
}
