import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/home_google_ad_banner_view_controller.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeGoogleAdBannerView extends StatelessWidget {
  final HomeGoogleAdBannerViewController homeGoogleAdBannerViewController = Get.put(HomeGoogleAdBannerViewController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      color: Theme.of(context).backgroundColor,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: new AdWidget(ad: homeGoogleAdBannerViewController.ad),
      ),
    );
  }
}
