import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter_lebei_exchange/modules/pages/home/controllers/googlead_banner_controller.dart';

class HomeGoogleAdBannerView extends StatelessWidget {
  final HomeGoogleAdBannerController homeGoogleAdBannerController = Get.put(HomeGoogleAdBannerController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      color: Theme.of(context).backgroundColor,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: AdWidget(ad: homeGoogleAdBannerController.ad),
      ),
    );
  }
}
