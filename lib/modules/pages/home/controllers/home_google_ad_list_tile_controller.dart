import 'package:flutter_lebei_exchange/modules/common/ad/google/helpers/helper.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeGoogleAdListTileController extends GetxController {
  late BannerAd bannerAd;
  final isAdLoaded = false.obs;

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
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          throw ('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
      request: AdRequest(),
    );

    bannerAd.load();
  }

  @override
  void onClose() {
    bannerAd.dispose();
    super.onClose();
  }
}