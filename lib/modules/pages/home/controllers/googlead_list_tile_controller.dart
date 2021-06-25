import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter_lebei_exchange/modules/commons/ad/google/helpers/helper.dart';

class HomeGoogleAdListTileController extends GetxController {
  late BannerAd bannerAd;
  final RxBool isAdLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();

    bannerAd = BannerAd(
      size: SmartBannerAdSize(Get.context!.orientation),
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isAdLoaded.value = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          throw Exception('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
      request: const AdRequest(),
    );
    bannerAd.load();
  }

  @override
  void onClose() {
    bannerAd.dispose();
    super.onClose();
  }
}
