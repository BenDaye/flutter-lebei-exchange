import 'package:carousel_slider/carousel_slider.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class MarketPopularSymbol extends StatefulWidget {
  MarketPopularSymbol({Key? key}) : super(key: key);

  @override
  _MarketPopularSymbolState createState() => _MarketPopularSymbolState();
}

class _MarketPopularSymbolState extends State<MarketPopularSymbol> {
  int _currentIndex = 0;
  List _list = [];

  void _onPageChanged(int index, CarouselPageChangedReason reason) {
    if (mounted) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  List<List> computeList(List l) {
    int _length = int.parse((l.length / 3).toStringAsFixed(0));
    Map<int, List> _l = {};
    for (var i = 0; i < _length; i++) {
      int _endIndex = (i + 1) * 3 > l.length ? l.length : (i + 1) * 3;
      _l[i] = l.sublist(i * 3, _endIndex);
    }
    return _l.values.toList();
  }

  @override
  void initState() {
    super.initState();
    _list = List.generate(
        5,
        (index) => {
              'id': index,
              'symbol': 'BTC/USDT',
              'rate': '+2.00%',
              'price': '57171.17',
              'cny': '374757.01',
            }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<List> splitedList = computeList(_list);
    CarouselSlider carouselSlider = CarouselSlider.builder(
      itemCount: splitedList.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        List symbols = List.filled(3, {})..setRange(0, splitedList[index].length, splitedList[index]);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: symbols
                .map(
                  (symbol) => Expanded(
                    child: ObjectUtil.isEmpty(symbol)
                        ? Container()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(symbol['symbol']),
                              Text(symbol['rate']),
                              Text(symbol['price']),
                              Text(symbol['cny']),
                            ],
                          ),
                  ),
                )
                .toList(),
          ),
        );
      },
      options: CarouselOptions(
        height: 100.0,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: false,
        enlargeCenterPage: false,
        onPageChanged: _onPageChanged,
        scrollDirection: Axis.horizontal,
      ),
    );
    return Container(
      padding: EdgeInsets.only(bottom: 8.0),
      color: Theme.of(context).bottomAppBarColor,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 100.0,
            child: carouselSlider,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: splitedList
                .asMap()
                .entries
                .map(
                  (e) => Container(
                    width: 8.0,
                    height: 2.0,
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                      color: e.key == _currentIndex ? Theme.of(context).accentColor : Theme.of(context).dividerColor,
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
