import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/googlead_list_tile_controller.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeGoogleAdListTile extends StatelessWidget {
  final HomeGoogleAdListTileController homeGoogleAdListTileController =
      Get.put(HomeGoogleAdListTileController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.0,
      margin: const EdgeInsets.only(bottom: 4.0),
      color: Theme.of(context).backgroundColor,
      alignment: Alignment.center,
      child: AdWidget(ad: homeGoogleAdListTileController.bannerAd),
    );
  }
}
