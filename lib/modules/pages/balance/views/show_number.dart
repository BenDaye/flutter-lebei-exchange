import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/balances_controller.dart';

class ShowNumber extends GetView<BalancesViewController> {
  const ShowNumber({required this.child});
  final Text child;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedCrossFade(
        duration: const Duration(milliseconds: 300),
        firstChild: child,
        secondChild: Text('*****', style: child.style?.copyWith(color: Theme.of(context).disabledColor), maxLines: 1),
        sizeCurve: Curves.easeInOutQuad,
        crossFadeState: controller.showNumber.isTrue ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
    );
  }
}
