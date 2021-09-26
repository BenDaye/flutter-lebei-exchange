import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/balances_controller.dart';
import 'show_number.dart';

class BalancesView extends GetView<BalancesViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 160),
        child: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: SafeArea(
            bottom: false,
            left: false,
            right: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '总账户资产折合(BTC)',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      ShowNumber(
                        child: Text(
                          '3.141592653',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ],
                  ),
                  subtitle: ShowNumber(
                    child: Text(
                      '≈ 68.88221199 CNY',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  trailing: Obx(
                    () => IconButton(
                      onPressed: () => controller.showNumber.toggle(),
                      icon: Icon(controller.showNumber.isTrue ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.secondary.withAlpha(201),
                          ),
                          child: const Text('充币'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.secondary.withAlpha(201),
                          ),
                          child: const Text('提币'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.secondary.withAlpha(201),
                          ),
                          child: const Text('划转'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).backgroundColor,
            child: Obx(
              () => CheckboxListTile(
                value: controller.hideLessCurrency.value,
                onChanged: (bool? hide) => controller.hideLessCurrency.toggle(),
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
                title: const Text('隐藏小额币种'),
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemBuilder: (BuildContext context, int index) => ListTile(
                minVerticalPadding: 8,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'USDT',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 12,
                        color: Theme.of(context).dividerColor,
                      ),
                    ],
                  ),
                ),
                subtitle: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('可用', style: Theme.of(context).textTheme.caption),
                          const SizedBox(height: 4),
                          ShowNumber(
                            child: Text(
                              '4.00000000',
                              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: Theme.of(context).textTheme.bodyText1?.color,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('可用', style: Theme.of(context).textTheme.caption),
                          const SizedBox(height: 4),
                          ShowNumber(
                            child: Text(
                              '4.00000000',
                              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: Theme.of(context).textTheme.bodyText1?.color,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('可用', style: Theme.of(context).textTheme.caption),
                          const SizedBox(height: 4),
                          ShowNumber(
                            child: Text(
                              '4.00000000',
                              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: Theme.of(context).textTheme.bodyText1?.color,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
