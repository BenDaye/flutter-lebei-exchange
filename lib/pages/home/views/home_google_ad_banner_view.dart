import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/pages/home/controllers/home_google_ad_banner_view_controller.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeGoogleAdBannerView extends StatelessWidget {
  final HomeGoogleAdBannerViewController homeGoogleAdBannerViewController = Get.put(HomeGoogleAdBannerViewController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.0,
      margin: const EdgeInsets.only(top: 4.0),
      color: Theme.of(context).backgroundColor,
      alignment: Alignment.center,
      child: AdWidget(ad: homeGoogleAdBannerViewController.bannerAd),
    );
  }
}
