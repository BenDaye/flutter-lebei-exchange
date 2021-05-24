import 'package:flutter_lebei_exchange/utils/http/models/ccxt/market.dart';

class UpdateMarketsAction {
  final Map<String, Market> markets;
  UpdateMarketsAction(this.markets);

  @override
  String toString() {
    return 'UpdateMarketsAction(markets: $markets)';
  }
}
