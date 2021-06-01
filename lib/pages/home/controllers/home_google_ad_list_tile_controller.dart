import 'package:flutter_lebei_exchange/components/ad/google/helpers/helper.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeGoogleAdListTileController extends GetxController {
  late BannerAd bannerAd;
  final isAdLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    bannerAd = BannerAd(
      size: AdSize.largeBanner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
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
