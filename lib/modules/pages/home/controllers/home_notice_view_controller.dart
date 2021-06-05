import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class HomeNoticeViewController extends GetxController {
  final currentIndex = 0.obs;
  final notices = <Map<String, dynamic>>[].obs;
  CarouselController carouselController = CarouselController();

  @override
  void onInit() {
    super.onInit();
    notices.value = List<Map<String, dynamic>>.filled(3, {'title': 'LeBei Global'});
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    currentIndex.value = index;
  }
}
