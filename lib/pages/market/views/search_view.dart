import 'package:flutter/material.dart';
import 'package:flutter_lebei_exchange/pages/market/controllers/search_view_controller.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchMarketView extends StatelessWidget {
  final SearchViewController searchViewController = Get.put(SearchViewController(), permanent: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: Theme.of(context).scaffoldBackgroundColor),
          FloatingSearchBar(
            hint: 'MarketsPage.Search.Hint'.tr,
            scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
            transitionDuration: const Duration(milliseconds: 800),
            transitionCurve: Curves.easeInOut,
            physics: const BouncingScrollPhysics(),
            openAxisAlignment: 0.0,
            width: 600,
            debounceDelay: Duration(milliseconds: 500),
            onQueryChanged: searchViewController.onChangeQuery,
            transition: CircularFloatingSearchBarTransition(),
            controller: searchViewController.floatingSearchBarController,
            automaticallyImplyBackButton: false,
            leadingActions: [
              FloatingSearchBarAction.icon(
                icon: Icon(Icons.arrow_back_ios, size: 18),
                onTap: () => Get.back(),
                showIfOpened: true,
              ),
            ],
            actions: [FloatingSearchBarAction.searchToClear(showIfClosed: false)],
            builder: (BuildContext context, transition) => ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: searchViewController.symbols.isNotEmpty
                        ? searchViewController.symbols
                            .map<ListTile>(
                              (e) => ListTile(
                                title: Text(e),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  size: 14,
                                  color: Theme.of(context).dividerColor,
                                ),
                                selected: searchViewController.symbolController.favoriteSymbols.contains(e),
                                onTap: () {
                                  searchViewController.floatingSearchBarController.close();
                                  searchViewController.symbolController.onChangeCurrentSymbol(e);
                                  Get.toNamed('/market');
                                },
                                onLongPress: () {
                                  searchViewController.symbolController.toggleFavoriteSymbol(e);
                                },
                              ),
                            )
                            .toList()
                        : [
                            ListTile(
                              title: Text('MarketsPage.Search.Recommanded'.tr),
                              subtitle: Wrap(
                                spacing: 16,
                                children: <String>['BTC', 'ETH', 'DOGE', 'SHIB', 'XCH', 'FIL']
                                    .map<OutlinedButton>(
                                      (String e) => OutlinedButton(
                                        onPressed: () => searchViewController.floatingSearchBarController.query = e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
