import 'package:json_annotation/json_annotation.dart';

part 'exchange.g.dart';

enum PrecisionMode { DECIMAL_PLACES, SIGNIFICANT_DIGITS, TICK_SIZE }
enum PaddingMode { NO_PADDING, PAD_WITH_ZERO }

@JsonSerializable(explicitToJson: true)
class Exchange {
  String id;
  String name;
  List<String> countries;
  @JsonKey(defaultValue: true)
  bool enableRateLimit;
  @JsonKey(defaultValue: 2000)
  int rateLimit;
  Urls urls;
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

  static PrecisionMode _precisionModeFromJson(int? value) {
    switch (value) {
      case 1:
        return PrecisionMode.SIGNIFICANT_DIGITS;
      case 2:
        return PrecisionMode.TICK_SIZE;
      default:
        return PrecisionMode.DECIMAL_PLACES;
    }
  }

  static int _precisionModeToJson(PrecisionMode mode) {
    switch (mode) {
      case PrecisionMode.SIGNIFICANT_DIGITS:
        return 1;
      case PrecisionMode.TICK_SIZE:
        return 2;
      default:
        return 0;
    }
  }

  static PaddingMode _paddingModeFromJson(int? value) {
    switch (value) {
      case 1:
        return PaddingMode.PAD_WITH_ZERO;
      default:
        return PaddingMode.NO_PADDING;
    }
  }

  static int _paddingModeToJson(PaddingMode mode) {
    switch (mode) {
      case PaddingMode.PAD_WITH_ZERO:
        return 1;
      default:
        return 0;
    }
  }

  factory Exchange.fromJson(Map<String, dynamic> json) => _$ExchangeFromJson(json);
  Map<String, dynamic> toJson() => _$ExchangeToJson(this);

  static Exchange empty() => Exchange(
        '[id]',
        '[name]',
        [],
        true,
        2000,
        Urls(null, null, null),
        '[version]',
        {},
        Has.empty(),
        {},
        {},
        PrecisionMode.DECIMAL_PLACES,
        PaddingMode.NO_PADDING,
        '[hostname]',
      );
}

@JsonSerializable(explicitToJson: true)
class Urls {
  dynamic api;
  dynamic www;
  dynamic doc;

  Urls(this.api, this.www, this.doc);

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);
  Map<String, dynamic> toJson() => _$UrlsToJson(this);
}

enum HasType { TRUE, FALSE, EMULATED }

@JsonSerializable(explicitToJson: true)
class Has {
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

  static HasType _fromJson(dynamic value) {
    if (value == null) return HasType.FALSE;
    final valueString = value.toString();
    switch (valueString) {
      case 'true':
        return HasType.TRUE;
      case 'emulated':
        return HasType.EMULATED;
      default:
        return HasType.FALSE;
    }
  }

  static _toJson(HasType _type) {
    switch (_type) {
      case HasType.TRUE:
        return true;
      case HasType.EMULATED:
        return 'emulated';
      default:
        return false;
    }
  }

  factory Has.fromJson(Map<String, dynamic> json) => _$HasFromJson(json);
  Map<String, dynamic> toJson() => _$HasToJson(this);

  static Has empty() => Has(
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
        HasType.FALSE,
      );
}
