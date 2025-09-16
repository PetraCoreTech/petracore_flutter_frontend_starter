import '../../../generators/project_generator.dart';

String appbarv1Template(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import '../../theme/design_tokens/theme_token.dart';

/// Custom app bar with theming support for ${config.projectName}
/// 
/// A reusable app bar component that integrates with the app's design system
/// and provides consistent styling across the application.
class AppBarV1 extends StatelessWidget implements PreferredSizeWidget {
  /// Title text to display in the app bar
  final String? title;
  
  /// Custom title widget (overrides [title] if provided)
  final Widget? titleWidget;
  
  /// Leading widget (usually back button or menu icon)
  final Widget? leading;
  
  /// Action widgets to display on the right side
  final List<Widget>? actions;
  
  /// Whether to show the back button automatically
  final bool automaticallyImplyLeading;
  
  /// Background color override
  final Color? backgroundColor;
  
  /// Foreground color override (affects text and icons)
  final Color? foregroundColor;
  
  /// Elevation of the app bar
  final double elevation;
  
  /// Whether to center the title
  final bool centerTitle;
  
  /// Bottom widget (like TabBar)
  final PreferredSizeWidget? bottom;
  
  /// Custom height for the app bar
  final double? toolbarHeight;

  /// Constructor
  const AppBarV1({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.centerTitle = true,
    this.bottom,
    this.toolbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    final colors = \$token.color;
    final textStyles = \$token.textStyle;
    
    return AppBar(
      title: titleWidget ?? (title != null ? Text(
        title!,
        style: textStyles.titleMedium?.copyWith(
          color: foregroundColor ?? colors.onPrimary,
          fontWeight: FontWeight.w600,
        ),
      ) : null),
      leading: leading,
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor ?? colors.primary,
      foregroundColor: foregroundColor ?? colors.onPrimary,
      elevation: elevation,
      centerTitle: centerTitle,
      bottom: bottom,
      toolbarHeight: toolbarHeight,
      iconTheme: IconThemeData(
        color: foregroundColor ?? colors.onPrimary,
        size: 24,
      ),
      actionsIconTheme: IconThemeData(
        color: foregroundColor ?? colors.onPrimary,
        size: 24,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    (toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0),
  );
}

/// Transparent app bar variant
class AppBarV1Transparent extends AppBarV1 {
  const AppBarV1Transparent({
    super.key,
    super.title,
    super.titleWidget,
    super.leading,
    super.actions,
    super.automaticallyImplyLeading,
    super.foregroundColor,
    super.centerTitle,
    super.bottom,
    super.toolbarHeight,
  }) : super(
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}

/// Secondary themed app bar
class AppBarV1Secondary extends AppBarV1 {
  const AppBarV1Secondary({
    super.key,
    super.title,
    super.titleWidget,
    super.leading,
    super.actions,
    super.automaticallyImplyLeading,
    super.centerTitle,
    super.bottom,
    super.toolbarHeight,
    super.elevation,
  });
  
  @override
  Widget build(BuildContext context) {
    final colors = \$token.color;
    
    return AppBarV1(
      title: title,
      titleWidget: titleWidget,
      leading: leading,
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: colors.surface,
      foregroundColor: colors.onSurface,
      elevation: elevation,
      centerTitle: centerTitle,
      bottom: bottom,
      toolbarHeight: toolbarHeight,
    );
  }
}
''';
