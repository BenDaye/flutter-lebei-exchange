import 'package:flutter_lebei_exchange/modules/common/ad/google/helpers/helper.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeGoogleAdBannerViewController extends GetxController {
  late BannerAd ad;
  final isAdLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();

    ad = BannerAd(
      size: AdSize.fullBanner,
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

    ad.load();
  }

  @override
  void onClose() {
    ad.dispose();
    super.onClose();
  }
}
