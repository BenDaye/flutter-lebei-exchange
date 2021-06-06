import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/banner_controller.dart';
import 'package:flutter_lebei_exchange/modules/pages/home/controllers/notice_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

class HomePullToRefreshHeader extends StatelessWidget {
  final PullToRefreshScrollNotificationInfo? info;
  HomePullToRefreshHeader(this.info);

  final HomeBannerController homeBannerController = Get.find<HomeBannerController>();
  final HomeNoticeController homeNoticeController = Get.find<HomeNoticeController>();

  static const double maxDragOffset = 60.0;

  @override
  Widget build(BuildContext context) {
    if (info == null || info?.mode == null) {
      return Container();
    }
    final double dragOffset = info?.dragOffset ?? 0;
    final double progressValue = dragOffset / maxDragOffset;
    switch (info?.mode) {
      case RefreshIndicatorMode.armed:
        {
          return Container(
            height: dragOffset,
            child: Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  value: 1,
                ),
              ),
            ),
          );
        }
      case RefreshIndicatorMode.drag:
        {
          homeBannerController.carouselController.stopAutoPlay();
          homeNoticeController.carouselController.stopAutoPlay();
          return Container(
            height: dragOffset,
            child: Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  value: progressValue,
                ),
              ),
            ),
          );
        }
      case RefreshIndicatorMode.refresh:
        {
          return Container(
            height: dragOffset,
            child: Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      case RefreshIndicatorMode.snap:
        {
          return Container(
            height: dragOffset,
            child: Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      case RefreshIndicatorMode.canceled:
        {
          homeBannerController.carouselController.startAutoPlay();
          homeNoticeController.carouselController.startAutoPlay();
          return Container(
            height: dragOffset,
            child: Center(
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  value: progressValue,
                ),
              ),
            ),
          );
        }
      case RefreshIndicatorMode.done:
        {
          homeBannerController.carouselController.startAutoPlay();
          homeNoticeController.carouselController.startAutoPlay();
          return Container();
        }
      default:
        {
          return Container();
        }
    }
  }
}
