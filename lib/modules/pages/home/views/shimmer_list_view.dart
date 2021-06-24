import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListView extends StatelessWidget {
  const ShimmerListView({this.itemCount = 3});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, __) => ShimmerListTile(),
      itemCount: itemCount,
      physics: const ClampingScrollPhysics(),
    );
  }
}

class ShimmerListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListTile(
        leading: Container(
          height: 24,
          width: 88,
          color: Colors.white,
        ),
        title: Container(
          height: 24,
          width: 88,
          color: Colors.white,
        ),
        trailing: Container(
          height: 24,
          width: 96,
          color: Colors.white,
        ),
      ),
    );
  }
}
