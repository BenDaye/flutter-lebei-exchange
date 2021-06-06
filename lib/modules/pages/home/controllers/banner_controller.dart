import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class HomeBannerController extends GetxController {
  final currentIndex = 0.obs;
  final banners = <Map<String, dynamic>>[].obs;
  CarouselController carouselController = CarouselController();

  @override
  void onInit() {
    super.onInit();
    banners.value = List<Map<String, dynamic>>.filled(3, {'image': 'https://jdc.jd.com/img/960x240'});
  }

  @override
  void onReady() {
    super.onReady();
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    currentIndex.value = index;
  }
}
