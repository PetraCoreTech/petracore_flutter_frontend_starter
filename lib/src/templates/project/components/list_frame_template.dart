import '../../../generators/project_generator.dart';

String listframeTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import '../../theme/design_tokens/theme_token.dart';

/// List frame component with consistent styling for ${config.projectName}
/// 
/// A reusable frame for displaying lists with background, border, and theming support.
/// Provides consistent styling for different types of list presentations.
class ListFrame extends StatelessWidget {
  /// Child widget to display inside the frame
  final Widget child;
  
  /// Background color of the frame
  final Color? backgroundColor;
  
  /// Border color
  final Color? borderColor;
  
  /// Border width
  final double borderWidth;
  
  /// Border radius
  final BorderRadius? borderRadius;
  
  /// Margin around the frame
  final EdgeInsets? margin;
  
  /// Padding inside the frame
  final EdgeInsets? padding;
  
  /// Elevation for shadow
  final double elevation;
  
  /// Whether to clip the content to the border radius
  final bool clipBehavior;
  
  /// Frame constraints
  final BoxConstraints? constraints;

  /// Constructor
  const ListFrame({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.borderRadius,
    this.margin,
    this.padding,
    this.elevation = 0,
    this.clipBehavior = false,
    this.constraints,
  });
  
  /// Factory constructor for card-style list frame
  factory ListFrame.card({
    Key? key,
    required Widget child,
    Color? backgroundColor,
    EdgeInsets? margin,
    EdgeInsets? padding,
    double elevation = 1,
    BorderRadius? borderRadius,
  }) {
    return ListFrame(
      key: key,
      child: child,
      backgroundColor: backgroundColor,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: padding ?? const EdgeInsets.all(16),
      elevation: elevation,
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      clipBehavior: true,
    );
  }
  
  /// Factory constructor for bordered list frame
  factory ListFrame.bordered({
    Key? key,
    required Widget child,
    Color? backgroundColor,
    Color? borderColor,
    double borderWidth = 1,
    BorderRadius? borderRadius,
    EdgeInsets? margin,
    EdgeInsets? padding,
  }) {
    return ListFrame(
      key: key,
      child: child,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      margin: margin,
      padding: padding ?? const EdgeInsets.all(12),
      clipBehavior: true,
    );
  }
  
  /// Factory constructor for minimal list frame
  factory ListFrame.minimal({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    BoxConstraints? constraints,
  }) {
    return ListFrame(
      key: key,
      child: child,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      constraints: constraints,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = \$token.color;
    
    Widget content = child;
    
    // Apply padding if specified
    if (padding != null) {
      content = Padding(
        padding: padding!,
        child: content,
      );
    }
    
    // Create the frame container
    Widget frame = Container(
      constraints: constraints,
      decoration: BoxDecoration(
        color: backgroundColor ?? (elevation > 0 ? colors.surface : null),
        borderRadius: borderRadius,
        border: borderWidth > 0 ? Border.all(
          color: borderColor ?? colors.outline,
          width: borderWidth,
        ) : null,
        boxShadow: elevation > 0 ? [
          BoxShadow(
            color: colors.shadow.withOpacity(0.1),
            blurRadius: elevation * 2,
            offset: Offset(0, elevation),
          ),
        ] : null,
      ),
      child: clipBehavior && borderRadius != null
        ? ClipRRect(
            borderRadius: borderRadius!,
            child: content,
          )
        : content,
    );
    
    // Apply margin if specified
    if (margin != null) {
      frame = Padding(
        padding: margin!,
        child: frame,
      );
    }
    
    return frame;
  }
}

/// Specialized list frame for displaying grouped content
class GroupedListFrame extends StatelessWidget {
  /// Title for the group
  final String? title;
  
  /// Custom title widget (overrides [title] if provided)
  final Widget? titleWidget;
  
  /// List items to display
  final List<Widget> children;
  
  /// Whether to add dividers between items
  final bool showDividers;
  
  /// Custom divider widget
  final Widget? divider;
  
  /// Background color of the frame
  final Color? backgroundColor;
  
  /// Border radius
  final BorderRadius? borderRadius;
  
  /// Margin around the frame
  final EdgeInsets? margin;
  
  /// Padding inside the frame
  final EdgeInsets? padding;
  
  /// Title padding
  final EdgeInsets? titlePadding;
  
  /// Elevation for shadow
  final double elevation;

  const GroupedListFrame({
    super.key,
    this.title,
    this.titleWidget,
    required this.children,
    this.showDividers = true,
    this.divider,
    this.backgroundColor,
    this.borderRadius,
    this.margin,
    this.padding,
    this.titlePadding,
    this.elevation = 1,
  });

  @override
  Widget build(BuildContext context) {
    final colors = \$token.color;
    final textStyles = \$token.textStyle;
    
    List<Widget> frameChildren = [];
    
    // Add title if provided
    if (title != null || titleWidget != null) {
      Widget titleChild = titleWidget ?? Text(
        title!,
        style: textStyles.titleSmall?.copyWith(
          color: colors.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      );
      
      frameChildren.add(
        Padding(
          padding: titlePadding ?? const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: titleChild,
        ),
      );
    }
    
    // Add list items with optional dividers
    for (int i = 0; i < children.length; i++) {
      frameChildren.add(children[i]);
      
      if (showDividers && i < children.length - 1) {
        frameChildren.add(
          divider ?? Divider(
            height: 1,
            thickness: 0.5,
            color: colors.outline.withOpacity(0.3),
            indent: 16,
            endIndent: 16,
          ),
        );
      }
    }
    
    return ListFrame(
      backgroundColor: backgroundColor,
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: padding,
      elevation: elevation,
      clipBehavior: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: frameChildren,
      ),
    );
  }
}

/// Expandable list frame that can show/hide content
class ExpandableListFrame extends StatefulWidget {
  /// Title for the expandable section
  final String title;
  
  /// Custom title widget (overrides [title] if provided)
  final Widget? titleWidget;
  
  /// Content to show when expanded
  final Widget child;
  
  /// Whether initially expanded
  final bool initiallyExpanded;
  
  /// Background color of the frame
  final Color? backgroundColor;
  
  /// Border radius
  final BorderRadius? borderRadius;
  
  /// Margin around the frame
  final EdgeInsets? margin;
  
  /// Padding inside the frame
  final EdgeInsets? padding;
  
  /// Title padding
  final EdgeInsets? titlePadding;
  
  /// Content padding
  final EdgeInsets? contentPadding;
  
  /// Elevation for shadow
  final double elevation;
  
  /// Callback when expansion state changes
  final void Function(bool)? onExpansionChanged;

  const ExpandableListFrame({
    super.key,
    required this.title,
    this.titleWidget,
    required this.child,
    this.initiallyExpanded = false,
    this.backgroundColor,
    this.borderRadius,
    this.margin,
    this.padding,
    this.titlePadding,
    this.contentPadding,
    this.elevation = 1,
    this.onExpansionChanged,
  });

  @override
  State<ExpandableListFrame> createState() => _ExpandableListFrameState();
}

class _ExpandableListFrameState extends State<ExpandableListFrame> {
  late bool _isExpanded;
  
  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final colors = \$token.color;
    final textStyles = \$token.textStyle;
    
    return ListFrame(
      backgroundColor: widget.backgroundColor,
      borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
      margin: widget.margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: widget.padding,
      elevation: widget.elevation,
      clipBehavior: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title section with expand/collapse button
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
              widget.onExpansionChanged?.call(_isExpanded);
            },
            child: Padding(
              padding: widget.titlePadding ?? const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: widget.titleWidget ?? Text(
                      widget.title,
                      style: textStyles.titleMedium?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Expandable content
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: widget.contentPadding ?? const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: widget.child,
            ),
            crossFadeState: _isExpanded 
              ? CrossFadeState.showSecond 
              : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
''';
