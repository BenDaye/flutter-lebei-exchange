import 'package:get/get.dart';

class MarketPanelController extends GetxController {
  static const double panelMaxHeight = 600.0;
  static const double panelHeaderHeight = 20.0;
  static const double panelTabBarHeight = 48.0;
  static const double panelTabViewMaxHeight = panelMaxHeight - panelHeaderHeight - panelTabBarHeight;

  final RxDouble panelSlide = 0.0.obs;
  final RxDouble panelTabViewHeight = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    ever(panelSlide, watchPanelSlide);
  }

  void watchPanelSlide(double _slide) {
    final double _panelTabViewHeight = panelTabViewMaxHeight * _slide;
    panelTabViewHeight.value = _panelTabViewHeight;
  }

  // ignore: use_setters_to_change_properties
  void onChangePanelSlide(double _slide) {
    panelSlide.value = _slide;
  }
}
