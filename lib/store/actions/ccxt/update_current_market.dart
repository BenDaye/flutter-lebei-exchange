import 'package:flutter_lebei_exchange/utils/http/models/ccxt/market.dart';

class UpdateCurrentMarketAction {
  final Market market;
  UpdateCurrentMarketAction(this.market);

  @override
  String toString() {
    return 'UpdateCurrentMarketAction(market: $market)';
  }
}
