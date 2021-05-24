import 'package:carousel_slider/carousel_options.dart';
import 'package:get/get.dart';

class SymbolPopularGridViewController extends GetxController {
  final currentIndex = 0.obs;

  void onChangePageIndex(int index, CarouselPageChangedReason reason) {
    currentIndex.value = index;
  }
}
