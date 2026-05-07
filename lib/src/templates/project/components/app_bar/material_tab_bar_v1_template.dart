import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialTabBarV1Template(ProjectConfig config) => '''
import 'package:flutter/material.dart';

class TabBarV1 extends StatelessWidget implements PreferredSizeWidget {
  const TabBarV1({
    required this.tabs,
    super.key,
    this.hasIndicator = true,
    this.indicator,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.controller,
    this.tabSize,
    this.padding,
    this.indicatorWeight,
    this.indicatorSize,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.onTap,
    this.ignoring,
    this.physics,
  });
  final bool hasIndicator;
  final bool? ignoring;
  final Size? tabSize;
  final Decoration? indicator;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final List<Widget> tabs;
  final TabController? controller;
  final EdgeInsetsGeometry? padding;
  final double? indicatorWeight;
  final TabBarIndicatorSize? indicatorSize;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final void Function(int)? onTap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.bodySmall?.copyWith(
          height: 1.43,
          fontWeight: FontWeight.w500,
        );
    return IgnorePointer(
      ignoring: ignoring ?? false,
      child: TabBar(
        tabs: tabs,
        padding: padding,
        onTap: onTap,
        physics: physics,
        indicator: hasIndicator
            ? (indicator ??
                BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.08),
                ))
            : null,
        controller: controller,
        dividerColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        isScrollable: true,
        indicatorPadding: EdgeInsets.zero,
        indicatorColor: indicatorColor ?? theme.colorScheme.primary,
        indicatorWeight: indicatorWeight ?? 3,
        indicatorSize: indicatorSize ?? TabBarIndicatorSize.tab,
        labelColor: labelColor,
        unselectedLabelColor: unselectedLabelColor,
        labelStyle: labelStyle ??
            style?.copyWith(
              color: theme.colorScheme.primary,
            ),
        unselectedLabelStyle: unselectedLabelStyle ??
            style?.copyWith(color: theme.colorScheme.outline),
        tabAlignment: TabAlignment.start,
      ),
    );
  }

  @override
  Size get preferredSize => tabSize ?? const Size.fromHeight(kToolbarHeight);
}
''';
