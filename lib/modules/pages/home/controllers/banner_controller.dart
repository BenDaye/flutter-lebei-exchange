import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class HomeBannerController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxList<Map<String, dynamic>> banners = <Map<String, dynamic>>[].obs;
  CarouselController carouselController = CarouselController();

  @override
  void onInit() {
    super.onInit();
    banners.value = List<Map<String, dynamic>>.filled(3, <String, String>{'image': 'https://jdc.jd.com/img/960x240'});
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    currentIndex.value = index;
  }
}
