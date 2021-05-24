import 'package:carousel_slider/carousel_slider.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeBanner extends StatefulWidget {
  HomeBanner({Key? key}) : super(key: key);

  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  List _banners = [];
  int _currentIndex = 0;

  void _onPageChanged(int index, CarouselPageChangedReason reason) {
    if (mounted) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ObjectUtil.isEmptyList(_banners)) {
      getBanners();
    }
  }

  Future<List> getBanners() async {
    List list = List.filled(3, {'image': 'https://jdc.jd.com/img/760x240'}).toList();
    setState(() {
      _banners = list;
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    CarouselSlider carouselSlider = CarouselSlider.builder(
      itemCount: _banners.length,
      itemBuilder: (BuildContext context, int index, int realIndex) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: _banners[index]['image'],
            fit: BoxFit.cover,
          ),
        ),
      ),
      options: CarouselOptions(
        height: 160.0,
        viewportFraction: 1,
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
        onPageChanged: _onPageChanged,
        scrollDirection: Axis.horizontal,
      ),
    );
    return Container(
      height: 168.0,
      color: Theme.of(context).bottomAppBarColor,
      child: ObjectUtil.isEmptyList(_banners)
          ? SizedBox()
          : Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                carouselSlider,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _banners.asMap().entries.map((entry) {
                    int index = entry.key;
                    return Container(
                      width: 8.0,
                      height: 2.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        color: _currentIndex == index ? Theme.of(context).accentColor : Theme.of(context).dividerColor,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
    );
  }
}
