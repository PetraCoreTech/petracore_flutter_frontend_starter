import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String tabBarV1Template(ProjectConfig config) => '''
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/core/core.dart';

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
    final colors = \$token.color;
    final style = \$token.textStyle.label3.resolve(context).copyWith(
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
                  color: colors.primaryDark
                      .resolve(context)
                      .withValues(alpha: 0.08),
                ))
            : null,
        controller: controller,
        dividerColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        isScrollable: true,
        indicatorPadding: EdgeInsets.zero,
        indicatorColor: indicatorColor ?? colors.primary.resolve(context),
        indicatorWeight: indicatorWeight ?? 3,
        indicatorSize: indicatorSize ?? TabBarIndicatorSize.tab,
        labelColor: labelColor,
        unselectedLabelColor: unselectedLabelColor,
        labelStyle: labelStyle ??
            style.copyWith(
              color: colors.primaryDark.resolve(context),
            ),
        unselectedLabelStyle: unselectedLabelStyle ??
            style.copyWith(color: colors.onSurfaceLight.resolve(context)),
        tabAlignment: TabAlignment.start,
      ),
    );
  }

  @override
  Size get preferredSize => tabSize ?? const Size.fromHeight(kToolbarHeight);
}
''';
