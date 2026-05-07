import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialSliverHelperTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:${config.projectName}/core/core.dart';

class SliverHelper {
  SliverHelper(this.context);
  final BuildContext context;

  static Widget buildSliverFillRemaining({
    bool hasScrollBody = false,
    Widget? child,
  }) {
    return SliverFillRemaining(
      hasScrollBody: hasScrollBody,
      child: child,
    );
  }

  static Widget buildScrollable(Widget child) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(right: 16),
      child: child,
    );
  }

  static Widget buildCustomScrollWidget({required Widget child}) {
    return CustomScrollView(
      slivers: [SliverFillRemaining(hasScrollBody: false, child: child)],
    );
  }

  static Widget buildSliverSeparatedList({
    required int itemCount,
    required Widget? Function(BuildContext, int) itemBuilder,
    required Widget? Function(BuildContext, int) separatorBuilder,
    EdgeInsets? padding,
  }) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: padding ?? EdgeInsets.zero,
          sliver: SliverList.separated(
            separatorBuilder: separatorBuilder,
            itemBuilder: itemBuilder,
            itemCount: itemCount,
          ),
        ),
      ],
    );
  }

  Widget buildPageBreadCrumb({required String text, bool pinned = true}) {
    final theme = Theme.of(context);
    const height = 32.0;
    return SliverPersistentHeader(
      pinned: pinned,
      delegate: _PersistentHeaderDelegate(
        toolbarHeight: height,
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerHighest),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  _PersistentHeaderDelegate({required this.toolbarHeight, required this.child});

  final double toolbarHeight;
  final Widget child;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => toolbarHeight;

  @override
  double get minExtent => toolbarHeight;

  @override
  bool shouldRebuild(_PersistentHeaderDelegate oldDelegate) => false;
}
''';
