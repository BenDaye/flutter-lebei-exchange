import '../utils/http/handler/types.dart';
import '../utils/http/main.dart';
import 'url/juhe.dart';

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
