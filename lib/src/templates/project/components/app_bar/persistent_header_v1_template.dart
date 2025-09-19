import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String persistentHeaderV1Template(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:${config.projectName}/app/app.dart';

class PersistentHeaderV1 extends SliverPersistentHeaderDelegate {
  PersistentHeaderV1({
    required this.title,
    this.titleStyle,
    this.minTitleSize,
    this.maxTitleSize,
    this.toolbarHeight,
    this.titleAlignment,
  });
  final double? toolbarHeight;
  final double? minTitleSize;
  final double? maxTitleSize;
  final String title;
  final TextStyle? titleStyle;
  final AlignmentGeometry? titleAlignment;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final colors = \$token.color;
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: toolbarHeight ?? 42,
      alignment: titleAlignment ?? Alignment.center,
      width: size.width,
      color: colors.surface.resolve(context),
      child: Text(
        title,
        style: titleStyle,
      ),
    );
  }

  @override
  double get maxExtent => toolbarHeight ?? 42;

  @override
  double get minExtent => toolbarHeight ?? 42;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
''';
