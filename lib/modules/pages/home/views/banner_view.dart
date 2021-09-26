import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

import '../controllers/banner_controller.dart';

class HomeBannerView extends GetView<HomeBannerController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128.0,
      color: Theme.of(context).backgroundColor,
      child: controller.banners.isEmpty
          ? Container()
          : Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                CarouselSlider.builder(
                  carouselController: controller.carouselController,
                  itemCount: controller.banners.length,
                  itemBuilder: (BuildContext context, int index, int realIndex) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: controller.banners[index]['image'] as String,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  options: CarouselOptions(
                    height: 120.0,
                    viewportFraction: 1,
                    autoPlay: true,
                    autoPlayInterval: const Duration(milliseconds: 10 * 1000),
                    pauseAutoPlayInFiniteScroll: true,
                    enlargeCenterPage: true,
                    onPageChanged: controller.onPageChanged,
                  ),
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: controller.banners.asMap().entries.map((MapEntry<int, Map<String, dynamic>> entry) {
                      final int index = entry.key;
                      return Container(
                        width: 8.0,
                        height: 2.0,
                        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          color: controller.currentIndex.value == index
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).dividerColor,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
