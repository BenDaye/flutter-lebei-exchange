import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/pages/home/controllers/home_notice_view_controller.dart';
import 'package:get/get.dart';

class HomeNoticeView extends GetView<HomeNoticeViewController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      color: Theme.of(context).backgroundColor,
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
          Expanded(
            child: controller.notices.isEmpty
                ? Container()
                : CarouselSlider.builder(
                    carouselController: controller.carouselController,
                    itemCount: controller.notices.length,
                    itemBuilder: (BuildContext context, int index, int realIndex) => Container(
                      child: Text(controller.notices[index]['title']),
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
                  ),
          ),
        ],
      ),
    );
  }
}
