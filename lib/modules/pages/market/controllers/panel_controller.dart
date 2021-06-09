import 'package:get/get.dart';

class MarketPanelController extends GetxController {
  static const panelMaxHeight = 600.0;
  static const panelHeaderHeight = 20.0;
  static const panelTabBarHeight = 48.0;
  static const panelTabViewMaxHeight = panelMaxHeight - panelHeaderHeight - panelTabBarHeight;

  final panelSlide = 0.0.obs;
  final panelTabViewHeight = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    ever(panelSlide, watchPanelSlide);
  }

  void watchPanelSlide(double _slide) {
    double _panelTabViewHeight = panelTabViewMaxHeight * _slide;
    panelTabViewHeight.value = _panelTabViewHeight;
  }

  onChangePanelSlide(double _slide) {
    panelSlide.value = _slide;
  }
}
