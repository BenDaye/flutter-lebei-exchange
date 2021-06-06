// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exchange _$ExchangeFromJson(Map<String, dynamic> json) {
  return Exchange(
    json['id'] as String,
    json['name'] as String,
    (json['countries'] as List<dynamic>).map((e) => e as String).toList(),
    json['enableRateLimit'] as bool? ?? true,
    json['rateLimit'] as int? ?? 2000,
    Urls.fromJson(json['urls'] as Map<String, dynamic>),
    json['version'] as String,
    json['api'] as Map<String, dynamic>,
    Has.fromJson(json['has'] as Map<String, dynamic>),
    (json['timeframes'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    Map<String, bool>.from(json['requiredCredentials'] as Map),
    Exchange._precisionModeFromJson(json['precisionMode'] as int?),
    Exchange._paddingModeFromJson(json['paddingMode'] as int?),
    json['hostname'] as String?,
  );
}

Map<String, dynamic> _$ExchangeToJson(Exchange instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'countries': instance.countries,
      'enableRateLimit': instance.enableRateLimit,
      'rateLimit': instance.rateLimit,
      'urls': instance.urls.toJson(),
      'version': instance.version,
      'api': instance.api,
      'has': instance.has.toJson(),
      'timeframes': instance.timeframes,
      'requiredCredentials': instance.requiredCredentials,
      'precisionMode': Exchange._precisionModeToJson(instance.precisionMode),
      'paddingMode': Exchange._paddingModeToJson(instance.paddingMode),
      'hostname': instance.hostname,
    };

Urls _$UrlsFromJson(Map<String, dynamic> json) {
  return Urls(
    json['api'],
    json['www'],
    json['doc'],
  );
}

Map<String, dynamic> _$UrlsToJson(Urls instance) => <String, dynamic>{
      'api': instance.api,
      'www': instance.www,
      'doc': instance.doc,
    };

Has _$HasFromJson(Map<String, dynamic> json) {
  return Has(
    Has._fromJson(json['CORS']),
    Has._fromJson(json['publicAPI']),
    Has._fromJson(json['privateAPI']),
    Has._fromJson(json['cancelOrder']),
    Has._fromJson(json['createDepositAddress']),
    Has._fromJson(json['createOrder']),
    Has._fromJson(json['deposit']),
    Has._fromJson(json['fetchBalance']),
    Has._fromJson(json['fetchClosedOrders']),
    Has._fromJson(json['fetchCurrencies']),
    Has._fromJson(json['fetchDepositAddress']),
    Has._fromJson(json['fetchMarkets']),
    Has._fromJson(json['fetchMyTrades']),
    Has._fromJson(json['fetchOHLCV']),
    Has._fromJson(json['fetchOpenOrders']),
    Has._fromJson(json['fetchOrder']),
    Has._fromJson(json['fetchOrderBook']),
    Has._fromJson(json['fetchOrders']),
    Has._fromJson(json['fetchStatus']),
    Has._fromJson(json['fetchTicker']),
    Has._fromJson(json['fetchTickers']),
    Has._fromJson(json['fetchBidsAsks']),
    Has._fromJson(json['fetchTrades']),
    Has._fromJson(json['withdraw']),
  );
}

Map<String, dynamic> _$HasToJson(Has instance) => <String, dynamic>{
      'CORS': Has._toJson(instance.cors),
      'publicAPI': Has._toJson(instance.publicAPI),
      'privateAPI': Has._toJson(instance.privateAPI),
      'cancelOrder': Has._toJson(instance.cancelOrder),
      'createDepositAddress': Has._toJson(instance.createDepositAddress),
      'createOrder': Has._toJson(instance.createOrder),
      'deposit': Has._toJson(instance.deposit),
      'fetchBalance': Has._toJson(instance.fetchBalance),
      'fetchClosedOrders': Has._toJson(instance.fetchClosedOrders),
      'fetchCurrencies': Has._toJson(instance.fetchCurrencies),
      'fetchDepositAddress': Has._toJson(instance.fetchDepositAddress),
      'fetchMarkets': Has._toJson(instance.fetchMarkets),
      'fetchMyTrades': Has._toJson(instance.fetchMyTrades),
      'fetchOHLCV': Has._toJson(instance.fetchOHLCV),
      'fetchOpenOrders': Has._toJson(instance.fetchOpenOrders),
      'fetchOrder': Has._toJson(instance.fetchOrder),
      'fetchOrderBook': Has._toJson(instance.fetchOrderBook),
      'fetchOrders': Has._toJson(instance.fetchOrders),
      'fetchStatus': Has._toJson(instance.fetchStatus),
      'fetchTicker': Has._toJson(instance.fetchTicker),
      'fetchTickers': Has._toJson(instance.fetchTickers),
      'fetchBidsAsks': Has._toJson(instance.fetchBidsAsks),
      'fetchTrades': Has._toJson(instance.fetchTrades),
      'withdraw': Has._toJson(instance.withdraw),
    };
