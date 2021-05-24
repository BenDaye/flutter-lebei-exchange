import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/api/ccxt.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/market.dart';
import 'package:flutter_lebei_exchange/utils/http/models/ccxt/ticker.dart';
import 'package:get/get.dart';

class CcxtController extends GetxController {
  final exchanges = <String>[].obs;
  final currentExchangeId = ''.obs;

  final currentSymbol = ''.obs;

  final markets = <Market>[].obs;
  final marketsMap = <String, Market>{}.obs;

  final favoriteSymbols = <String>[].obs;

  final tickers = <Ticker>[].obs;
  final tickersMap = <String, Ticker>{}.obs;
  final topBaseVolumeTickers = <Ticker>[].obs;
  final topQuoteVolumeTickers = <Ticker>[].obs;
  final topPercentageTickers = <Ticker>[].obs;

  final sortRegexp =
      new RegExp(r'^BTC|ETH|DOT|XRP|LINK|BCH|LTC|ADA|EOS|TRX|XMR|IOTA|DASH|ETC|ZEC|USDC|PAX|WBTC|SHIB|DOGE|FIL');

  @override
  Future onInit() async {
    super.onInit();
    await this.getExchanges();
    ever(currentExchangeId, watchCurrentExchangeId);
    ever(currentSymbol, watchCurrentSymbol);
    ever(tickers, watchTickers);
    this.setCurrentExchange(SpUtil.getString('currentExchangeId') ?? '');
  }

  void watchCurrentExchangeId(String exchangeId) async {
    if (exchangeId.isEmpty) {
      Get.offNamed('/exchanges');
    } else {
      Get.offNamed('/');
      Get.showSnackbar(GetBar(
        messageText: Text('已切换至[$exchangeId]'),
        snackStyle: SnackStyle.GROUNDED,
        snackPosition: SnackPosition.TOP,
        duration: Duration(milliseconds: 3000),
        forwardAnimationCurve: Curves.fastOutSlowIn,
        reverseAnimationCurve: Curves.fastOutSlowIn,
        backgroundColor: Colors.green,
      ));
    }
  }

  void watchCurrentSymbol(String symbol) async {
    if (symbol.isNotEmpty) {}
  }

  void watchTickers(List<Ticker> _tickers) {
    final _topPercentageTickers =
        List<Ticker>.from(_tickers.where((t) => t.symbol.contains('/USDT') || t.symbol.contains('/BTC')));
    _topPercentageTickers.sort((a, b) => (b.percentage ?? double.nan).compareTo((a.percentage ?? double.nan)));
    topPercentageTickers.value = _topPercentageTickers.getRange(0, 20).toList();

    final _topBaseVolumeTickers =
        List<Ticker>.from(_tickers.where((t) => !(t.symbol.contains('3S') || t.symbol.contains('2S'))));
    _topBaseVolumeTickers.sort((a, b) => (b.baseVolume ?? double.nan).compareTo((a.baseVolume ?? double.nan)));
    topBaseVolumeTickers.value = _topBaseVolumeTickers.getRange(0, 20).toList();

    final _topQuoteVolumeTickers =
        List<Ticker>.from(_tickers.where((t) => !(t.symbol.contains('3S') || t.symbol.contains('2S'))));
    _topQuoteVolumeTickers.sort((a, b) => (b.quoteVolume ?? double.nan).compareTo((a.quoteVolume ?? double.nan)));
    topQuoteVolumeTickers.value = _topQuoteVolumeTickers.getRange(0, 20).toList();
  }

  Future getExchanges() async {
    final result = await ApiCcxt.exchanges();
    if (result.success) {
      exchanges.value = List<String>.from(result.data!);
    }
  }

  Future _getMarkets() async {
    if (currentExchangeId.isEmpty) return;
    final result = await this.getMarkets(currentExchangeId.value);
    marketsMap.value = result;
    markets.value = result.values.toList();
  }

  Future<Map<String, Market>> getMarkets(String exchangeId) async {
    if (exchangeId.isEmpty) return {};
    final result = await ApiCcxt.markets(exchangeId);
    if (result.success) return result.data!.map<String, Market>((key, value) => MapEntry(key, Market.fromJson(value)));
    return {};
  }

  Future _getTickers() async {
    if (currentExchangeId.isEmpty) return;
    final result = await this.getTickers(currentExchangeId.value);
    tickersMap.value = result;
    tickers.value = result.values.toList();
  }

  Future<Map<String, Ticker>> getTickers(String exchangeId) async {
    if (exchangeId.isEmpty) return {};
    final result = await ApiCcxt.tickers(exchangeId);
    if (result.success) return result.data!.map<String, Ticker>((key, value) => MapEntry(key, Ticker.fromJson(value)));
    return {};
  }

  Future refreshTickers() async {
    await this._getTickers();
  }

  List<Ticker> filterTickers({String? quote, bool? unknown = false, bool? margin = false, bool? standard = true}) {
    List<Ticker> _tickers = List<Ticker>.from(tickers);

    if (unknown == false) _tickers.removeWhere((t) => t.symbol.contains(RegExp(r'[a-z]')));
    if (standard == false) _tickers.removeWhere((t) => !t.symbol.contains(RegExp(r"[1-9]\d*[LS]")));
    if (margin == false) _tickers.removeWhere((t) => t.symbol.contains(RegExp(r"[1-9]\d*[LS]")));

    if (quote != null && quote.isNotEmpty && quote != 'ALL')
      _tickers = _tickers.where((t) => t.symbol.endsWith(quote)).toList();

    _tickers.sort((a, b) {
      if (a.symbol.startsWith(sortRegexp) && !b.symbol.startsWith(sortRegexp)) {
        return -1;
      } else if (!a.symbol.startsWith(sortRegexp) && b.symbol.startsWith(sortRegexp)) {
        return 1;
      } else {
        return a.symbol.compareTo(b.symbol);
      }
    });
    return _tickers;
  }

  Future<Market?> getMarket(String exchangeId, String symbol) async {
    if (exchangeId.isEmpty || symbol.isEmpty) return null;
    final result = await ApiCcxt.market(exchangeId, symbol);
    if (result.success) return Market.fromJson(result.data!.map((key, value) => MapEntry(key, value)));
    return null;
  }

  void setCurrentExchange(String exchangeId) async {
    if (exchanges.contains(exchangeId)) {
      currentExchangeId.value = exchangeId;
      SpUtil.putString('currentExchangeId', exchangeId);
      await this._getMarkets();
      await this._getTickers();
      this.setCurrentSymbol(currentSymbol.value);
    } else {
      currentExchangeId.value = '';
    }
  }

  void setCurrentSymbol(String symbol) {
    if (markets.contains(symbol)) {
      currentSymbol.value = symbol;
    } else {
      currentSymbol.value = '';
    }
  }

  void toggleFavoriteSymbol(String symbol) {
    if (marketsMap.containsKey(symbol)) {
      if (favoriteSymbols.contains(symbol)) {
        favoriteSymbols.remove(symbol);
        Get.showSnackbar(
          GetBar(
            message: '已将$symbol移除自选',
            snackPosition: SnackPosition.TOP,
            snackStyle: SnackStyle.GROUNDED,
            duration: Duration(seconds: 2),
            backgroundColor: Colors.orange,
          ),
        );
      } else {
        favoriteSymbols.add(symbol);
        Get.showSnackbar(
          GetBar(
            message: '已将$symbol添加自选',
            snackPosition: SnackPosition.TOP,
            snackStyle: SnackStyle.GROUNDED,
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }
}
