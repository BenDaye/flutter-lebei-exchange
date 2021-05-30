import 'package:flutter_lebei_exchange/api/url/juhe.dart';
import 'package:flutter_lebei_exchange/utils/http/handler/types.dart';
import 'package:flutter_lebei_exchange/utils/http/main.dart';

class ApiJuhe {
  static Future<HttpResult<List>> exchangeQuery() async {
    return await http.request<List>(UrlJuhe.exchangeQuery);
  }

  static Future<HttpResult<List>> exchangeList() async {
    return await http.request<List>(UrlJuhe.exchangeList);
  }

  static Future<HttpResult<List>> exchangeCurrency(String from, String to) async {
    return await http.request<List>(UrlJuhe.exchangeCurrency(from, to));
  }
}
