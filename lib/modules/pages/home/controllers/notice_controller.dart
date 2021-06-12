import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class HomeNoticeController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxList<Map<String, dynamic>> notices = <Map<String, dynamic>>[].obs;
  CarouselController carouselController = CarouselController();

  @override
  void onInit() {
    super.onInit();
    notices.value = List<Map<String, dynamic>>.filled(3, <String, String>{'title': 'LeBei Global'});
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    currentIndex.value = index;
  }
}
