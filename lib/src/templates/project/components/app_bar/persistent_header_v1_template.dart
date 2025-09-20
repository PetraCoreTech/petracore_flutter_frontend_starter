import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String persistentHeaderV1Template(ProjectConfig config) => '''
import 'package:flutter/material.dart';

class PersistentHeaderV1 extends SliverPersistentHeaderDelegate {
  PersistentHeaderV1({
    required this.child,
    this.toolbarHeight,
  });
  final double? toolbarHeight;
  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => toolbarHeight ?? 42;

  @override
  double get minExtent => toolbarHeight ?? 32;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
''';
