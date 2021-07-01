import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.watchLogoShown(true),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
              child: SizedBox(
                width: 320,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: TextLiquidFill(
                    text: 'LeBei Global',
                    waveColor: Colors.orange,
                    loadDuration: const Duration(seconds: 3),
                    textStyle: Theme.of(context).textTheme.headline3!.copyWith(
                          fontFamily: GoogleFonts.bigShouldersStencilDisplay().fontFamily,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 8,
                        ),
                    boxBackgroundColor: Theme.of(context).scaffoldBackgroundColor.withRed(120),
                    boxHeight: 120,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Shimmer.fromColors(
                  baseColor: Theme.of(context).unselectedWidgetColor,
                  highlightColor: Theme.of(context).highlightColor,
                  child: Text(
                    'Welcome to Lebei Global'.tr,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Theme.of(context).unselectedWidgetColor,
                  highlightColor: Theme.of(context).highlightColor,
                  child: Text(
                    'Cryptocurrency Exchanges All In One'.tr,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
