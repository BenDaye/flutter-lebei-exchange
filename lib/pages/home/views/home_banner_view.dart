import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/pages/home/controllers/home_banner_view_controller.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeBannerView extends GetView<HomeBannerViewController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128.0,
      color: Theme.of(context).backgroundColor,
      child: controller.banners.isEmpty
          ? SizedBox()
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
                        image: controller.banners[index]['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  options: CarouselOptions(
                    height: 120.0,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(milliseconds: 10 * 1000),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayInFiniteScroll: true,
                    pauseAutoPlayOnTouch: true,
                    pauseAutoPlayOnManualNavigate: true,
                    enlargeCenterPage: true,
                    onPageChanged: controller.onPageChanged,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: controller.banners.asMap().entries.map((entry) {
                      int index = entry.key;
                      return Container(
                        width: 8.0,
                        height: 2.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          color: controller.currentIndex.value == index
                              ? Theme.of(context).accentColor
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
