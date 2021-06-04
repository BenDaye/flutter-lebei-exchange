class LocalExchangeModel {
  LocalExchangeModel({
    required this.id,
    required this.icon,
    required this.name,
  });
  String id;
  String icon;
  String name;

  static LocalExchangeModel empty() => LocalExchangeModel(id: '[UNKNOWN_ID]', icon: '', name: '[UNKNOWN_NAME]');
}

class LocalExchange {
  static List<LocalExchangeModel> exchanges = <LocalExchangeModel>[
    LocalExchangeModel(
      id: 'aax',
      icon: 'https://user-images.githubusercontent.com/1294454/104140087-a27f2580-53c0-11eb-87c1-5d9e81208fe9.jpg',
      name: 'AAX',
    ),
    LocalExchangeModel(
      id: 'aofex',
      icon: 'https://user-images.githubusercontent.com/51840849/77670271-056d1080-6f97-11ea-9ac2-4268e9ed0c1f.jpg',
      name: 'AOFEX',
    ),
    LocalExchangeModel(
      id: 'ascendex',
      icon: 'https://user-images.githubusercontent.com/1294454/112027508-47984600-8b48-11eb-9e17-d26459cc36c6.jpg',
      name: 'AscendEX',
    ),
    LocalExchangeModel(
      id: 'bequant',
      icon: 'https://user-images.githubusercontent.com/1294454/55248342-a75dfe00-525a-11e9-8aa2-05e9dca943c6.jpg',
      name: 'Bequant',
    ),
    LocalExchangeModel(
      id: 'bibox',
      icon: 'https://user-images.githubusercontent.com/51840849/77257418-3262b000-6c85-11ea-8fb8-20bdf20b3592.jpg',
      name: 'Bibox',
    ),
    LocalExchangeModel(
      id: 'bigone',
      icon: 'https://user-images.githubusercontent.com/1294454/69354403-1d532180-0c91-11ea-88ed-44c06cefdf87.jpg',
      name: 'BigONE',
    ),
    LocalExchangeModel(
      id: 'binance',
      icon: 'https://user-images.githubusercontent.com/1294454/29604020-d5483cdc-87ee-11e7-94c7-d1a8d9169293.jpg',
      name: 'Binance',
    ),
    LocalExchangeModel(
      id: 'binancecoinm',
      icon: 'https://user-images.githubusercontent.com/1294454/117738721-668c8d80-b205-11eb-8c49-3fad84c4a07f.jpg',
      name: 'Binance COIN-M',
    ),
    LocalExchangeModel(
      id: 'binanceus',
      icon: 'https://user-images.githubusercontent.com/1294454/65177307-217b7c80-da5f-11e9-876e-0b748ba0a358.jpg',
      name: 'Binance US',
    ),
    LocalExchangeModel(
      id: 'binanceusdm',
      icon: 'https://user-images.githubusercontent.com/1294454/117738721-668c8d80-b205-11eb-8c49-3fad84c4a07f.jpg',
      name: 'Binance USDⓈ-M',
    ),
    LocalExchangeModel(
      id: 'bit2c',
      icon: 'https://user-images.githubusercontent.com/1294454/27766119-3593220e-5ece-11e7-8b3a-5a041f6bcc3f.jpg',
      name: 'Bit2C',
    ),
    LocalExchangeModel(
      id: 'bitbank',
      icon: 'https://user-images.githubusercontent.com/1294454/37808081-b87f2d9c-2e59-11e8-894d-c1900b7584fe.jpg',
      name: 'bitbank',
    ),
    LocalExchangeModel(
      id: 'bitbay',
      icon: 'https://user-images.githubusercontent.com/1294454/27766132-978a7bd8-5ece-11e7-9540-bc96d1e9bbb8.jpg',
      name: 'BitBay',
    ),
    LocalExchangeModel(
      id: 'bitbns',
      icon: 'https://user-images.githubusercontent.com/1294454/117201933-e7a6e780-adf5-11eb-9d80-98fc2a21c3d6.jpg',
      name: 'Bitbns',
    ),
    LocalExchangeModel(
      id: 'bitcoincom',
      icon: 'https://user-images.githubusercontent.com/1294454/97296144-514fa300-1861-11eb-952b-3d55d492200b.jpg',
      name: 'bitcoin.com',
    ),
    LocalExchangeModel(
      id: 'bitfinex',
      icon: 'https://user-images.githubusercontent.com/1294454/27766244-e328a50c-5ed2-11e7-947b-041416579bb3.jpg',
      name: 'Bitfinex',
    ),
    LocalExchangeModel(
      id: 'bitfinex2',
      icon: 'https://user-images.githubusercontent.com/1294454/27766244-e328a50c-5ed2-11e7-947b-041416579bb3.jpg',
      name: 'Bitfinex',
    ),
    LocalExchangeModel(
      id: 'bitflyer',
      icon: 'https://user-images.githubusercontent.com/1294454/28051642-56154182-660e-11e7-9b0d-6042d1e6edd8.jpg',
      name: 'bitFlyer',
    ),
    LocalExchangeModel(
      id: 'bitforex',
      icon: 'https://user-images.githubusercontent.com/51840849/87295553-1160ec00-c50e-11ea-8ea0-df79276a9646.jpg',
      name: 'Bitforex',
    ),
    LocalExchangeModel(
      id: 'bitget',
      icon: 'https://user-images.githubusercontent.com/51840849/88317935-a8a21c80-cd22-11ea-8e2b-4b9fac5975eb.jpg',
      name: 'Bitget',
    ),
    LocalExchangeModel(
      id: 'bithumb',
      icon: 'https://user-images.githubusercontent.com/1294454/30597177-ea800172-9d5e-11e7-804c-b9d4fa9b56b0.jpg',
      name: 'Bithumb',
    ),
    LocalExchangeModel(
      id: 'bitkk',
      icon: 'https://user-images.githubusercontent.com/1294454/32859187-cd5214f0-ca5e-11e7-967d-96568e2e2bd1.jpg',
      name: 'bitkk',
    ),
    LocalExchangeModel(
      id: 'bitmart',
      icon: 'https://user-images.githubusercontent.com/1294454/61835713-a2662f80-ae85-11e9-9d00-6442919701fd.jpg',
      name: 'BitMart',
    ),
    LocalExchangeModel(
      id: 'bitmex',
      icon: 'https://user-images.githubusercontent.com/1294454/27766319-f653c6e6-5ed4-11e7-933d-f0bc3699ae8f.jpg',
      name: 'BitMEX',
    ),
    LocalExchangeModel(
      id: 'bitpanda',
      icon: 'https://user-images.githubusercontent.com/51840849/87591171-9a377d80-c6f0-11ea-94ac-97a126eac3bc.jpg',
      name: 'Bitpanda Pro',
    ),
    LocalExchangeModel(
      id: 'bitso',
      icon: 'https://user-images.githubusercontent.com/51840849/87295554-11f98280-c50e-11ea-80d6-15b3bafa8cbf.jpg',
      name: 'Bitso',
    ),
    LocalExchangeModel(
      id: 'bitstamp',
      icon: 'https://user-images.githubusercontent.com/1294454/27786377-8c8ab57e-5fe9-11e7-8ea4-2b05b6bcceec.jpg',
      name: 'Bitstamp',
    ),
    LocalExchangeModel(
      id: 'bitstamp1',
      icon: 'https://user-images.githubusercontent.com/1294454/27786377-8c8ab57e-5fe9-11e7-8ea4-2b05b6bcceec.jpg',
      name: 'Bitstamp',
    ),
    LocalExchangeModel(
      id: 'bittrex',
      icon: 'https://user-images.githubusercontent.com/51840849/87153921-edf53180-c2c0-11ea-96b9-f2a9a95a455b.jpg',
      name: 'Bittrex',
    ),
    LocalExchangeModel(
      id: 'bitvavo',
      icon: 'https://user-images.githubusercontent.com/1294454/83165440-2f1cf200-a116-11ea-9046-a255d09fb2ed.jpg',
      name: 'Bitvavo',
    ),
    LocalExchangeModel(
      id: 'bitz',
      icon: 'https://user-images.githubusercontent.com/51840849/87443304-fec5e000-c5fd-11ea-98f8-ba8e67f7eaff.jpg',
      name: 'Bit-Z',
    ),
    LocalExchangeModel(
      id: 'bl3p',
      icon: 'https://user-images.githubusercontent.com/1294454/28501752-60c21b82-6feb-11e7-818b-055ee6d0e754.jpg',
      name: 'BL3P',
    ),
    LocalExchangeModel(
      id: 'braziliex',
      icon: 'https://user-images.githubusercontent.com/1294454/34703593-c4498674-f504-11e7-8d14-ff8e44fb78c1.jpg',
      name: 'Braziliex',
    ),
    LocalExchangeModel(
      id: 'btcalpha',
      icon: 'https://user-images.githubusercontent.com/1294454/42625213-dabaa5da-85cf-11e8-8f99-aa8f8f7699f0.jpg',
      name: 'BTC-Alpha',
    ),
    LocalExchangeModel(
      id: 'btcbox',
      icon: 'https://user-images.githubusercontent.com/51840849/87327317-98c55400-c53c-11ea-9a11-81f7d951cc74.jpg',
      name: 'BtcBox',
    ),
    LocalExchangeModel(
      id: 'btcmarkets',
      icon: 'https://user-images.githubusercontent.com/51840849/89731817-b3fb8480-da52-11ea-817f-783b08aaf32b.jpg',
      name: 'BTC Markets',
    ),
    LocalExchangeModel(
      id: 'btctradeua',
      icon: 'https://user-images.githubusercontent.com/1294454/27941483-79fc7350-62d9-11e7-9f61-ac47f28fcd96.jpg',
      name: 'BTC Trade UA',
    ),
    LocalExchangeModel(
      id: 'btcturk',
      icon: 'https://user-images.githubusercontent.com/51840849/87153926-efbef500-c2c0-11ea-9842-05b63612c4b9.jpg',
      name: 'BTCTurk',
    ),
    LocalExchangeModel(
      id: 'buda',
      icon: 'https://user-images.githubusercontent.com/1294454/47380619-8a029200-d706-11e8-91e0-8a391fe48de3.jpg',
      name: 'Buda',
    ),
    LocalExchangeModel(
      id: 'bw',
      icon: 'https://user-images.githubusercontent.com/1294454/69436317-31128c80-0d52-11ea-91d1-eb7bb5818812.jpg',
      name: 'BW',
    ),
    LocalExchangeModel(
      id: 'bybit',
      icon: 'https://user-images.githubusercontent.com/51840849/76547799-daff5b80-649e-11ea-87fb-3be9bac08954.jpg',
      name: 'Bybit',
    ),
    LocalExchangeModel(
      id: 'bytetrade',
      icon: 'https://user-images.githubusercontent.com/1294454/67288762-2f04a600-f4e6-11e9-9fd6-c60641919491.jpg',
      name: 'ByteTrade',
    ),
    LocalExchangeModel(
      id: 'cdax',
      icon: 'https://user-images.githubusercontent.com/1294454/102157692-fd406280-3e90-11eb-8d46-4511b617cd17.jpg',
      name: 'CDAX',
    ),
    LocalExchangeModel(
      id: 'cex',
      icon: 'https://user-images.githubusercontent.com/1294454/27766442-8ddc33b0-5ed8-11e7-8b98-f786aef0f3c9.jpg',
      name: 'CEX.IO',
    ),
    LocalExchangeModel(
      id: 'coinbase',
      icon: 'https://user-images.githubusercontent.com/1294454/40811661-b6eceae2-653a-11e8-829e-10bfadb078cf.jpg',
      name: 'Coinbase',
    ),
    LocalExchangeModel(
      id: 'coinbaseprime',
      icon: 'https://user-images.githubusercontent.com/1294454/44539184-29f26e00-a70c-11e8-868f-e907fc236a7c.jpg',
      name: 'Coinbase Prime',
    ),
    LocalExchangeModel(
      id: 'coinbasepro',
      icon: 'https://user-images.githubusercontent.com/1294454/41764625-63b7ffde-760a-11e8-996d-a6328fa9347a.jpg',
      name: 'Coinbase Pro',
    ),
    LocalExchangeModel(
      id: 'coincheck',
      icon: 'https://user-images.githubusercontent.com/51840849/87182088-1d6d6380-c2ec-11ea-9c64-8ab9f9b289f5.jpg',
      name: 'coincheck',
    ),
    LocalExchangeModel(
      id: 'coinegg',
      icon: 'https://user-images.githubusercontent.com/1294454/36770310-adfa764e-1c5a-11e8-8e09-449daac3d2fb.jpg',
      name: 'CoinEgg',
    ),
    LocalExchangeModel(
      id: 'coinex',
      icon: 'https://user-images.githubusercontent.com/51840849/87182089-1e05fa00-c2ec-11ea-8da9-cc73b45abbbc.jpg',
      name: 'CoinEx',
    ),
    LocalExchangeModel(
      id: 'coinfalcon',
      icon: 'https://user-images.githubusercontent.com/1294454/41822275-ed982188-77f5-11e8-92bb-496bcd14ca52.jpg',
      name: 'CoinFalcon',
    ),
    LocalExchangeModel(
      id: 'coinfloor',
      icon: 'https://user-images.githubusercontent.com/51840849/87153925-ef265e80-c2c0-11ea-91b5-020c804b90e0.jpg',
      name: 'coinfloor',
    ),
    LocalExchangeModel(
      id: 'coinmarketcap',
      icon: 'https://user-images.githubusercontent.com/51840849/87182086-1cd4cd00-c2ec-11ea-9ec4-d0cf2a2abf62.jpg',
      name: 'CoinMarketCap',
    ),
    LocalExchangeModel(
      id: 'coinmate',
      icon: 'https://user-images.githubusercontent.com/51840849/87460806-1c9f3f00-c616-11ea-8c46-a77018a8f3f4.jpg',
      name: 'CoinMate',
    ),
    LocalExchangeModel(
      id: 'coinone',
      icon: 'https://user-images.githubusercontent.com/1294454/38003300-adc12fba-323f-11e8-8525-725f53c4a659.jpg',
      name: 'CoinOne',
    ),
    LocalExchangeModel(
      id: 'coinspot',
      icon: 'https://user-images.githubusercontent.com/1294454/28208429-3cacdf9a-6896-11e7-854e-4c79a772a30f.jpg',
      name: 'CoinSpot',
    ),
    LocalExchangeModel(
      id: 'crex24',
      icon: 'https://user-images.githubusercontent.com/1294454/47813922-6f12cc00-dd5d-11e8-97c6-70f957712d47.jpg',
      name: 'CREX24',
    ),
    LocalExchangeModel(
      id: 'currencycom',
      icon: 'https://user-images.githubusercontent.com/1294454/83718672-36745c00-a63e-11ea-81a9-677b1f789a4d.jpg',
      name: 'Currency.com',
    ),
    LocalExchangeModel(
      id: 'delta',
      icon: 'https://user-images.githubusercontent.com/1294454/99450025-3be60a00-2931-11eb-9302-f4fd8d8589aa.jpg',
      name: 'Delta LocalExchangeModel',
    ),
    LocalExchangeModel(
      id: 'deribit',
      icon: 'https://user-images.githubusercontent.com/1294454/41933112-9e2dd65a-798b-11e8-8440-5bab2959fcb8.jpg',
      name: 'Deribit',
    ),
    LocalExchangeModel(
      id: 'digifinex',
      icon: 'https://user-images.githubusercontent.com/51840849/87443315-01283a00-c5fe-11ea-8628-c2a0feaf07ac.jpg',
      name: 'DigiFinex',
    ),
    LocalExchangeModel(
      id: 'equos',
      icon: 'https://user-images.githubusercontent.com/1294454/107758499-05edd180-6d38-11eb-9e09-0b69602a7a15.jpg',
      name: 'EQUOS',
    ),
    LocalExchangeModel(
      id: 'eterbase',
      icon: 'https://user-images.githubusercontent.com/1294454/82067900-faeb0f80-96d9-11ea-9f22-0071cfcb9871.jpg',
      name: 'Eterbase',
    ),
    LocalExchangeModel(
      id: 'exmo',
      icon: 'https://user-images.githubusercontent.com/1294454/27766491-1b0ea956-5eda-11e7-9225-40d67b481b8d.jpg',
      name: 'EXMO',
    ),
    LocalExchangeModel(
      id: 'exx',
      icon: 'https://user-images.githubusercontent.com/1294454/37770292-fbf613d0-2de4-11e8-9f79-f2dc451b8ccb.jpg',
      name: 'EXX',
    ),
    LocalExchangeModel(
      id: 'flowbtc',
      icon: 'https://user-images.githubusercontent.com/51840849/87443317-01c0d080-c5fe-11ea-95c2-9ebe1a8fafd9.jpg',
      name: 'flowBTC',
    ),
    LocalExchangeModel(
      id: 'ftx',
      icon: 'https://user-images.githubusercontent.com/1294454/67149189-df896480-f2b0-11e9-8816-41593e17f9ec.jpg',
      name: 'FTX',
    ),
    LocalExchangeModel(
      id: 'gateio',
      icon: 'https://user-images.githubusercontent.com/1294454/31784029-0313c702-b509-11e7-9ccc-bc0da6a0e435.jpg',
      name: 'Gate.io',
    ),
    LocalExchangeModel(
      id: 'gemini',
      icon: 'https://user-images.githubusercontent.com/1294454/27816857-ce7be644-6096-11e7-82d6-3c257263229c.jpg',
      name: 'Gemini',
    ),
    LocalExchangeModel(
      id: 'gopax',
      icon: 'https://user-images.githubusercontent.com/1294454/102897212-ae8a5e00-4478-11eb-9bab-91507c643900.jpg',
      name: 'GOPAX',
    ),
    LocalExchangeModel(
      id: 'hbtc',
      icon: 'https://user-images.githubusercontent.com/51840849/80134449-70663300-85a7-11ea-8942-e204cdeaab5d.jpg',
      name: 'HBTC',
    ),
    LocalExchangeModel(
      id: 'hitbtc',
      icon: 'https://user-images.githubusercontent.com/1294454/27766555-8eaec20e-5edc-11e7-9c5b-6dc69fc42f5e.jpg',
      name: 'HitBTC',
    ),
    LocalExchangeModel(
      id: 'hollaex',
      icon: 'https://user-images.githubusercontent.com/1294454/75841031-ca375180-5ddd-11ea-8417-b975674c23cb.jpg',
      name: 'HollaEx',
    ),
    LocalExchangeModel(
      id: 'huobijp',
      icon: 'https://user-images.githubusercontent.com/1294454/85734211-85755480-b705-11ea-8b35-0b7f1db33a2f.jpg',
      name: 'Huobi Japan',
    ),
    LocalExchangeModel(
      id: 'huobipro',
      icon: 'https://user-images.githubusercontent.com/1294454/76137448-22748a80-604e-11ea-8069-6e389271911d.jpg',
      name: 'Huobi Pro',
    ),
    LocalExchangeModel(
      id: 'idex',
      icon: 'https://user-images.githubusercontent.com/51840849/94481303-2f222100-01e0-11eb-97dd-bc14c5943a86.jpg',
      name: 'IDEX',
    ),
    LocalExchangeModel(
      id: 'independentreserve',
      icon: 'https://user-images.githubusercontent.com/51840849/87182090-1e9e9080-c2ec-11ea-8e49-563db9a38f37.jpg',
      name: 'Independent Reserve',
    ),
    LocalExchangeModel(
      id: 'indodax',
      icon: 'https://user-images.githubusercontent.com/51840849/87070508-9358c880-c221-11ea-8dc5-5391afbbb422.jpg',
      name: 'INDODAX',
    ),
    LocalExchangeModel(
      id: 'itbit',
      icon: 'https://user-images.githubusercontent.com/1294454/27822159-66153620-60ad-11e7-89e7-005f6d7f3de0.jpg',
      name: 'itBit',
    ),
    LocalExchangeModel(
      id: 'kraken',
      icon: 'https://user-images.githubusercontent.com/51840849/76173629-fc67fb00-61b1-11ea-84fe-f2de582f58a3.jpg',
      name: 'Kraken',
    ),
    LocalExchangeModel(
      id: 'kucoin',
      icon: 'https://user-images.githubusercontent.com/51840849/87295558-132aaf80-c50e-11ea-9801-a2fb0c57c799.jpg',
      name: 'KuCoin',
    ),
    LocalExchangeModel(
      id: 'kuna',
      icon: 'https://user-images.githubusercontent.com/51840849/87153927-f0578b80-c2c0-11ea-84b6-74612568e9e1.jpg',
      name: 'Kuna',
    ),
    LocalExchangeModel(
      id: 'latoken',
      icon: 'https://user-images.githubusercontent.com/1294454/61511972-24c39f00-aa01-11e9-9f7c-471f1d6e5214.jpg',
      name: 'Latoken',
    ),
    LocalExchangeModel(
      id: 'lbank',
      icon: 'https://user-images.githubusercontent.com/1294454/38063602-9605e28a-3302-11e8-81be-64b1e53c4cfb.jpg',
      name: 'LBank',
    ),
    LocalExchangeModel(
      id: 'liquid',
      icon: 'https://user-images.githubusercontent.com/1294454/45798859-1a872600-bcb4-11e8-8746-69291ce87b04.jpg',
      name: 'Liquid',
    ),
    LocalExchangeModel(
      id: 'luno',
      icon: 'https://user-images.githubusercontent.com/1294454/27766607-8c1a69d8-5ede-11e7-930c-540b5eb9be24.jpg',
      name: 'luno',
    ),
    LocalExchangeModel(
      id: 'lykke',
      icon: 'https://user-images.githubusercontent.com/1294454/34487620-3139a7b0-efe6-11e7-90f5-e520cef74451.jpg',
      name: 'Lykke',
    ),
    LocalExchangeModel(
      id: 'mercado',
      icon: 'https://user-images.githubusercontent.com/1294454/27837060-e7c58714-60ea-11e7-9192-f05e86adb83f.jpg',
      name: 'Mercado Bitcoin',
    ),
    LocalExchangeModel(
      id: 'mixcoins',
      icon: 'https://user-images.githubusercontent.com/51840849/87460810-1dd06c00-c616-11ea-9276-956f400d6ffa.jpg',
      name: 'MixCoins',
    ),
    LocalExchangeModel(
      id: 'ndax',
      icon: 'https://user-images.githubusercontent.com/1294454/108623144-67a3ef00-744e-11eb-8140-75c6b851e945.jpg',
      name: 'NDAX',
    ),
    LocalExchangeModel(
      id: 'novadax',
      icon: 'https://user-images.githubusercontent.com/1294454/92337550-2b085500-f0b3-11ea-98e7-5794fb07dd3b.jpg',
      name: 'NovaDAX',
    ),
    LocalExchangeModel(
      id: 'oceanex',
      icon: 'https://user-images.githubusercontent.com/1294454/58385970-794e2d80-8001-11e9-889c-0567cd79b78e.jpg',
      name: 'OceanEx',
    ),
    LocalExchangeModel(
      id: 'okcoin',
      icon: 'https://user-images.githubusercontent.com/51840849/87295551-102fbf00-c50e-11ea-90a9-462eebba5829.jpg',
      name: 'OKCoin',
    ),
    LocalExchangeModel(
      id: 'okex',
      icon: 'https://user-images.githubusercontent.com/1294454/32552768-0d6dd3c6-c4a6-11e7-90f8-c043b64756a7.jpg',
      name: 'OKEX',
    ),
    LocalExchangeModel(
      id: 'okex5',
      icon: 'https://user-images.githubusercontent.com/1294454/32552768-0d6dd3c6-c4a6-11e7-90f8-c043b64756a7.jpg',
      name: 'OKEX',
    ),
    LocalExchangeModel(
      id: 'paymium',
      icon: 'https://user-images.githubusercontent.com/51840849/87153930-f0f02200-c2c0-11ea-9c0a-40337375ae89.jpg',
      name: 'Paymium',
    ),
    LocalExchangeModel(
      id: 'phemex',
      icon: 'https://user-images.githubusercontent.com/1294454/85225056-221eb600-b3d7-11ea-930d-564d2690e3f6.jpg',
      name: 'Phemex',
    ),
    LocalExchangeModel(
      id: 'poloniex',
      icon: 'https://user-images.githubusercontent.com/1294454/27766817-e9456312-5ee6-11e7-9b3c-b628ca5626a5.jpg',
      name: 'Poloniex',
    ),
    LocalExchangeModel(
      id: 'probit',
      icon: 'https://user-images.githubusercontent.com/51840849/79268032-c4379480-7ea2-11ea-80b3-dd96bb29fd0d.jpg',
      name: 'ProBit',
    ),
    LocalExchangeModel(
      id: 'qtrade',
      icon: 'https://user-images.githubusercontent.com/51840849/80491487-74a99c00-896b-11ea-821e-d307e832f13e.jpg',
      name: 'qTrade',
    ),
    LocalExchangeModel(
      id: 'rightbtc',
      icon: 'https://user-images.githubusercontent.com/51840849/87182092-1f372700-c2ec-11ea-8f9e-01b4d3ff8941.jpg',
      name: 'RightBTC',
    ),
    LocalExchangeModel(
      id: 'ripio',
      icon: 'https://user-images.githubusercontent.com/1294454/94507548-a83d6a80-0218-11eb-9998-28b9cec54165.jpg',
      name: 'Ripio',
    ),
    LocalExchangeModel(
      id: 'southxchange',
      icon: 'https://user-images.githubusercontent.com/1294454/27838912-4f94ec8a-60f6-11e7-9e5d-bbf9bd50a559.jpg',
      name: 'SouthXchange',
    ),
    LocalExchangeModel(
      id: 'stex',
      icon: 'https://user-images.githubusercontent.com/1294454/69680782-03fd0b80-10bd-11ea-909e-7f603500e9cc.jpg',
      name: 'STEX',
    ),
    LocalExchangeModel(
      id: 'therock',
      icon: 'https://user-images.githubusercontent.com/1294454/27766869-75057fa2-5ee9-11e7-9a6f-13e641fa4707.jpg',
      name: 'TheRockTrading',
    ),
    LocalExchangeModel(
      id: 'tidebit',
      icon: 'https://user-images.githubusercontent.com/51840849/87460811-1e690280-c616-11ea-8652-69f187305add.jpg',
      name: 'TideBit',
    ),
    LocalExchangeModel(
      id: 'tidex',
      icon: 'https://user-images.githubusercontent.com/1294454/30781780-03149dc4-a12e-11e7-82bb-313b269d24d4.jpg',
      name: 'Tidex',
    ),
    LocalExchangeModel(
      id: 'timex',
      icon: 'https://user-images.githubusercontent.com/1294454/70423869-6839ab00-1a7f-11ea-8f94-13ae72c31115.jpg',
      name: 'TimeX',
    ),
    LocalExchangeModel(
      id: 'upbit',
      icon: 'https://user-images.githubusercontent.com/1294454/49245610-eeaabe00-f423-11e8-9cba-4b0aed794799.jpg',
      name: 'Upbit',
    ),
    LocalExchangeModel(
      id: 'vcc',
      icon: 'https://user-images.githubusercontent.com/1294454/100545356-8427f500-326c-11eb-9539-7d338242d61b.jpg',
      name: 'VCC LocalExchangeModel',
    ),
    LocalExchangeModel(
      id: 'wavesexchange',
      icon: 'https://user-images.githubusercontent.com/1294454/84547058-5fb27d80-ad0b-11ea-8711-78ac8b3c7f31.jpg',
      name: 'Waves.LocalExchangeModel',
    ),
    LocalExchangeModel(
      id: 'whitebit',
      icon: 'https://user-images.githubusercontent.com/1294454/66732963-8eb7dd00-ee66-11e9-849b-10d9282bb9e0.jpg',
      name: 'WhiteBit',
    ),
    LocalExchangeModel(
      id: 'xena',
      icon: 'https://user-images.githubusercontent.com/51840849/87489843-bb469280-c64c-11ea-91aa-69c6326506af.jpg',
      name: 'Xena LocalExchangeModel',
    ),
    LocalExchangeModel(
      id: 'yobit',
      icon: 'https://user-images.githubusercontent.com/1294454/27766910-cdcbfdae-5eea-11e7-9859-03fea873272d.jpg',
      name: 'YoBit',
    ),
    LocalExchangeModel(
      id: 'zaif',
      icon: 'https://user-images.githubusercontent.com/1294454/27766927-39ca2ada-5eeb-11e7-972f-1b4199518ca6.jpg',
      name: 'Zaif',
    ),
    LocalExchangeModel(
      id: 'zb',
      icon: 'https://user-images.githubusercontent.com/1294454/32859187-cd5214f0-ca5e-11e7-967d-96568e2e2bd1.jpg',
      name: 'ZB',
    ),
  ];
}
