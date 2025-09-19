import '../../../../generators/project_generator.dart';

String tabbarv1Template(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import '../../theme/design_tokens/theme_token.dart';

/// Custom tab bar with theming support for ${config.projectName}
/// 
/// A reusable tab bar component that integrates with the app's design system
/// and provides consistent styling across the application.
class TabBarV1 extends StatelessWidget implements PreferredSizeWidget {
  /// List of tabs to display
  final List<Widget> tabs;
  
  /// Tab controller for managing tab state
  final TabController? controller;
  
  /// Whether tabs are scrollable
  final bool isScrollable;
  
  /// Indicator color override
  final Color? indicatorColor;
  
  /// Label color for selected tabs
  final Color? labelColor;
  
  /// Label color for unselected tabs
  final Color? unselectedLabelColor;
  
  /// Label style for selected tabs
  final TextStyle? labelStyle;
  
  /// Label style for unselected tabs
  final TextStyle? unselectedLabelStyle;
  
  /// Indicator weight (thickness)
  final double indicatorWeight;
  
  /// Tab alignment when scrollable
  final TabAlignment tabAlignment;
  
  /// Physics for scrollable tabs
  final ScrollPhysics? physics;
  
  /// Padding around the tab bar
  final EdgeInsets? padding;
  
  /// Custom indicator decoration
  final Decoration? indicator;
  
  /// Size of the indicator
  final TabBarIndicatorSize? indicatorSize;
  
  /// Callback when tab is tapped
  final void Function(int)? onTap;

  /// Constructor
  const TabBarV1({
    super.key,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.indicatorWeight = 2.0,
    this.tabAlignment = TabAlignment.fill,
    this.physics,
    this.padding,
    this.indicator,
    this.indicatorSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = \$token.color;
    final textStyles = \$token.textStyle;
    
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          bottom: BorderSide(
            color: colors.outline.withOpacity(0.2),
            width: 0.5,
          ),
        ),
      ),
      child: TabBar(
        tabs: tabs,
        controller: controller,
        isScrollable: isScrollable,
        tabAlignment: tabAlignment,
        physics: physics,
        onTap: onTap,
        
        // Colors
        indicatorColor: indicatorColor ?? colors.primary,
        labelColor: labelColor ?? colors.primary,
        unselectedLabelColor: unselectedLabelColor ?? colors.onSurface.withOpacity(0.6),
        
        // Text Styles
        labelStyle: labelStyle ?? textStyles.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: unselectedLabelStyle ?? textStyles.labelLarge?.copyWith(
          fontWeight: FontWeight.w400,
        ),
        
        // Indicator
        indicatorWeight: indicatorWeight,
        indicator: indicator,
        indicatorSize: indicatorSize ?? TabBarIndicatorSize.tab,
        
        // Overlay color for tap feedback
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return colors.primary.withOpacity(0.1);
            }
            if (states.contains(WidgetState.hovered)) {
              return colors.primary.withOpacity(0.05);
            }
            return null;
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Scrollable tab bar variant
class TabBarV1Scrollable extends TabBarV1 {
  const TabBarV1Scrollable({
    super.key,
    required super.tabs,
    super.controller,
    super.indicatorColor,
    super.labelColor,
    super.unselectedLabelColor,
    super.labelStyle,
    super.unselectedLabelStyle,
    super.indicatorWeight,
    super.physics,
    super.padding,
    super.indicator,
    super.indicatorSize,
    super.onTap,
  }) : super(
    isScrollable: true,
    tabAlignment: TabAlignment.start,
  );
}

/// Minimal tab bar without background
class TabBarV1Minimal extends TabBarV1 {
  const TabBarV1Minimal({
    super.key,
    required super.tabs,
    super.controller,
    super.isScrollable,
    super.indicatorColor,
    super.labelColor,
    super.unselectedLabelColor,
    super.labelStyle,
    super.unselectedLabelStyle,
    super.indicatorWeight,
    super.tabAlignment,
    super.physics,
    super.padding,
    super.indicator,
    super.indicatorSize,
    super.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    final colors = \$token.color;
    final textStyles = \$token.textStyle;
    
    return Container(
      padding: padding,
      child: TabBar(
        tabs: tabs,
        controller: controller,
        isScrollable: isScrollable,
        tabAlignment: tabAlignment,
        physics: physics,
        onTap: onTap,
        
        // Colors
        indicatorColor: indicatorColor ?? colors.primary,
        labelColor: labelColor ?? colors.primary,
        unselectedLabelColor: unselectedLabelColor ?? colors.onSurface.withOpacity(0.6),
        
        // Text Styles
        labelStyle: labelStyle ?? textStyles.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: unselectedLabelStyle ?? textStyles.labelLarge?.copyWith(
          fontWeight: FontWeight.w400,
        ),
        
        // Indicator
        indicatorWeight: indicatorWeight,
        indicator: indicator,
        indicatorSize: indicatorSize ?? TabBarIndicatorSize.tab,
        
        // Remove divider
        dividerColor: Colors.transparent,
        
        // Overlay color for tap feedback
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return colors.primary.withOpacity(0.1);
            }
            if (states.contains(WidgetState.hovered)) {
              return colors.primary.withOpacity(0.05);
            }
            return null;
          },
        ),
      ),
    );
  }
}
''';
