import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/notice_controller.dart';

class HomeNoticeView extends GetView<HomeNoticeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: const Icon(
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
                    itemBuilder: (BuildContext context, int index, int realIndex) =>
                        Text(controller.notices[index]['title'] as String),
                    options: CarouselOptions(
                      height: 40.0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(milliseconds: 10 * 1000),
                      pauseAutoPlayInFiniteScroll: true,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.vertical,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
