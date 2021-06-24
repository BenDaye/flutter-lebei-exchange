import 'package:flutter_lebei_exchange/utils/formatter/common.dart';
import 'package:flutter_lebei_exchange/utils/formatter/string.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exchange.g.dart';

enum PrecisionMode { decimalPlaces, significantDigits, tickSize }
enum PaddingMode { noPadding, padWithZero }

@JsonSerializable(explicitToJson: true)
class Exchange {
  Exchange(
    this.id,
    this.name,
    this.countries,
    this.enableRateLimit,
    this.rateLimit,
    this.urls,
    this.version,
    this.api,
    this.has,
    this.timeframes,
    this.requiredCredentials,
    this.precisionMode,
    this.paddingMode,
    this.hostname,
  );

  Exchange.empty()
      : id = '[id]',
        name = '[name]',
        countries = <String>[],
        enableRateLimit = true,
        rateLimit = 2000,
        urls = Urls(null, null, null),
        version = '[version]',
        api = <String, dynamic>{},
        has = Has.empty(),
        timeframes = <String, String>{},
        requiredCredentials = <String, bool>{},
        precisionMode = PrecisionMode.decimalPlaces,
        paddingMode = PaddingMode.noPadding,
        hostname = '[hostname]';

  factory Exchange.fromJson(Map<String, dynamic> json) => _$ExchangeFromJson(json);
  Map<String, dynamic> toJson() => _$ExchangeToJson(this);

  static PrecisionMode _precisionModeFromJson(int? value) {
    switch (value) {
      case 1:
        return PrecisionMode.significantDigits;
      case 2:
        return PrecisionMode.tickSize;
      default:
        return PrecisionMode.decimalPlaces;
    }
  }

  static int _precisionModeToJson(PrecisionMode mode) {
    switch (mode) {
      case PrecisionMode.significantDigits:
        return 1;
      case PrecisionMode.tickSize:
        return 2;
      default:
        return 0;
    }
  }

  static PaddingMode _paddingModeFromJson(int? value) {
    switch (value) {
      case 1:
        return PaddingMode.padWithZero;
      default:
        return PaddingMode.noPadding;
    }
  }

  static int _paddingModeToJson(PaddingMode mode) {
    switch (mode) {
      case PaddingMode.padWithZero:
        return 1;
      default:
        return 0;
    }
  }

  @JsonKey(fromJson: StringFormatter.anyToString, toJson: CommonFormatter.whatever)
  String id;
  @JsonKey(fromJson: StringFormatter.anyToString, toJson: CommonFormatter.whatever)
  String name;
  List<String> countries;
  @JsonKey(defaultValue: true)
  bool enableRateLimit;
  @JsonKey(defaultValue: 2000)
  int rateLimit;
  Urls urls;
  @JsonKey(fromJson: StringFormatter.anyToString, toJson: CommonFormatter.whatever)
  String version;
  Map<String, dynamic> api;
  Has has;
  Map<String, String>? timeframes;
  Map<String, bool> requiredCredentials;
  @JsonKey(fromJson: _precisionModeFromJson, toJson: _precisionModeToJson)
  PrecisionMode precisionMode;
  @JsonKey(fromJson: _paddingModeFromJson, toJson: _paddingModeToJson)
  PaddingMode paddingMode;
  String? hostname;
}

@JsonSerializable(explicitToJson: true)
class Urls {
  Urls(this.api, this.www, this.doc);

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);
  Map<String, dynamic> toJson() => _$UrlsToJson(this);

  dynamic api;
  dynamic www;
  dynamic doc;
}

enum HasType { hasTrue, hasFalse, hasEmulated }

@JsonSerializable(explicitToJson: true)
class Has {
  Has(
    this.cors,
    this.publicAPI,
    this.privateAPI,
    this.cancelOrder,
    this.createDepositAddress,
    this.createOrder,
    this.deposit,
    this.fetchBalance,
    this.fetchClosedOrders,
    this.fetchCurrencies,
    this.fetchDepositAddress,
    this.fetchMarkets,
    this.fetchMyTrades,
    this.fetchOHLCV,
    this.fetchOpenOrders,
    this.fetchOrder,
    this.fetchOrderBook,
    this.fetchOrders,
    this.fetchStatus,
    this.fetchTicker,
    this.fetchTickers,
    this.fetchBidsAsks,
    this.fetchTrades,
    this.withdraw,
  );

  Has.empty()
      : cors = HasType.hasFalse,
        publicAPI = HasType.hasFalse,
        privateAPI = HasType.hasFalse,
        cancelOrder = HasType.hasFalse,
        createDepositAddress = HasType.hasFalse,
        createOrder = HasType.hasFalse,
        deposit = HasType.hasFalse,
        fetchBalance = HasType.hasFalse,
        fetchClosedOrders = HasType.hasFalse,
        fetchCurrencies = HasType.hasFalse,
        fetchDepositAddress = HasType.hasFalse,
        fetchMarkets = HasType.hasFalse,
        fetchMyTrades = HasType.hasFalse,
        fetchOHLCV = HasType.hasFalse,
        fetchOpenOrders = HasType.hasFalse,
        fetchOrder = HasType.hasFalse,
        fetchOrderBook = HasType.hasFalse,
        fetchOrders = HasType.hasFalse,
        fetchStatus = HasType.hasFalse,
        fetchTicker = HasType.hasFalse,
        fetchTickers = HasType.hasFalse,
        fetchBidsAsks = HasType.hasFalse,
        fetchTrades = HasType.hasFalse,
        withdraw = HasType.hasFalse;

  factory Has.fromJson(Map<String, dynamic> json) => _$HasFromJson(json);
  Map<String, dynamic> toJson() => _$HasToJson(this);

  @JsonKey(fromJson: _fromJson, toJson: _toJson, name: 'CORS')
  HasType cors;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType publicAPI;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType privateAPI;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType cancelOrder;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType createDepositAddress;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType createOrder;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType deposit;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType fetchBalance;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType fetchClosedOrders;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType fetchCurrencies;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType fetchDepositAddress;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType fetchMarkets;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType fetchMyTrades;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType fetchOHLCV;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType fetchOpenOrders;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType fetchOrder;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType fetchOrderBook;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType fetchOrders;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType fetchStatus;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType fetchTicker;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType fetchTickers;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType fetchBidsAsks;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType fetchTrades;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  HasType withdraw;

  static HasType _fromJson(dynamic value) {
    if (value == null) return HasType.hasFalse;
    final String valueString = value.toString();
    switch (valueString) {
      case 'true':
        return HasType.hasTrue;
      case 'emulated':
        return HasType.hasEmulated;
      default:
        return HasType.hasFalse;
    }
  }

  static Object _toJson(HasType _type) {
    switch (_type) {
      case HasType.hasTrue:
        return true;
      case HasType.hasEmulated:
        return 'emulated';
      default:
        return false;
    }
  }
}
