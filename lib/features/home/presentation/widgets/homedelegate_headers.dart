import 'package:flutter/material.dart';

class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  HomeHeaderDelegate({required this.child});

  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // Wrapping in a Container with color prevents content from showing behind
    // the header if it's transparent.
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      alignment: Alignment.center,
      child: child,
    );
  }

  @override
  double get maxExtent => 80; // The height of your header

  @override
  double get minExtent => 80; // Keep same as maxExtent for a "Fixed" height

  @override
  bool shouldRebuild(covariant HomeHeaderDelegate oldDelegate) => true;
}
