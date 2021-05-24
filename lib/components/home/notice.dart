import 'package:carousel_slider/carousel_slider.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class HomeNoticeBar extends StatefulWidget {
  HomeNoticeBar({Key? key}) : super(key: key);

  @override
  _HomeNoticeBarState createState() => _HomeNoticeBarState();
}

class _HomeNoticeBarState extends State<HomeNoticeBar> {
  List _artcles = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ObjectUtil.isEmptyList(_artcles)) {
      getArtcles();
    }
  }

  Future<List> getArtcles() async {
    List list = List.filled(3, {'title': 'LeBei Global'}).toList();
    setState(() {
      _artcles = list;
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    CarouselSlider carouselSlider = CarouselSlider.builder(
      itemCount: _artcles.length,
      itemBuilder: (BuildContext context, int index, int realIndex) => Container(
        child: Text(_artcles[index]['title']),
      ),
      options: CarouselOptions(
        height: 40.0,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayInFiniteScroll: true,
        pauseAutoPlayOnTouch: true,
        pauseAutoPlayOnManualNavigate: true,
        enlargeCenterPage: true,
        scrollDirection: Axis.vertical,
        scrollPhysics: NeverScrollableScrollPhysics(),
      ),
    );
    return Container(
      height: 40.0,
      color: Theme.of(context).bottomAppBarColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.emoji_events,
              size: 18,
            ),
          ),
          Expanded(child: ObjectUtil.isEmptyList(_artcles) ? SizedBox() : carouselSlider),
        ],
      ),
    );
  }
}
