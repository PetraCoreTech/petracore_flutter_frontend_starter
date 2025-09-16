import '../../../generators/project_generator.dart';

String iconframeTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import '../../theme/design_tokens/theme_token.dart';

/// Icon frame component with consistent styling for ${config.projectName}
/// 
/// A reusable frame for displaying icons with background, border, and theming support.
/// Useful for creating consistent icon presentations across the application.
class IconFrame extends StatelessWidget {
  /// The icon to display
  final IconData? iconData;
  
  /// Custom icon widget (overrides [iconData] if provided)
  final Widget? icon;
  
  /// Size of the frame
  final double size;
  
  /// Size of the icon inside the frame
  final double? iconSize;
  
  /// Background color of the frame
  final Color? backgroundColor;
  
  /// Icon color
  final Color? iconColor;
  
  /// Border color
  final Color? borderColor;
  
  /// Border width
  final double borderWidth;
  
  /// Border radius
  final BorderRadius? borderRadius;
  
  /// Frame shape
  final BoxShape shape;
  
  /// Elevation for shadow
  final double elevation;
  
  /// Padding inside the frame
  final EdgeInsets? padding;
  
  /// Tap callback
  final VoidCallback? onTap;
  
  /// Long press callback
  final VoidCallback? onLongPress;

  /// Constructor
  const IconFrame({
    super.key,
    this.iconData,
    this.icon,
    this.size = 48.0,
    this.iconSize,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.borderWidth = 0,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.elevation = 0,
    this.padding,
    this.onTap,
    this.onLongPress,
  }) : assert(iconData != null || icon != null, 'Either iconData or icon must be provided');

  /// Factory constructor for circular icon frame
  factory IconFrame.circular({
    Key? key,
    IconData? iconData,
    Widget? icon,
    double size = 48.0,
    double? iconSize,
    Color? backgroundColor,
    Color? iconColor,
    Color? borderColor,
    double borderWidth = 0,
    double elevation = 0,
    EdgeInsets? padding,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
  }) {
    return IconFrame(
      key: key,
      iconData: iconData,
      icon: icon,
      size: size,
      iconSize: iconSize,
      backgroundColor: backgroundColor,
      iconColor: iconColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      shape: BoxShape.circle,
      elevation: elevation,
      padding: padding,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
  
  /// Factory constructor for square icon frame with rounded corners
  factory IconFrame.rounded({
    Key? key,
    IconData? iconData,
    Widget? icon,
    double size = 48.0,
    double? iconSize,
    Color? backgroundColor,
    Color? iconColor,
    Color? borderColor,
    double borderWidth = 0,
    double elevation = 0,
    EdgeInsets? padding,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    double radius = 12.0,
  }) {
    return IconFrame(
      key: key,
      iconData: iconData,
      icon: icon,
      size: size,
      iconSize: iconSize,
      backgroundColor: backgroundColor,
      iconColor: iconColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: BorderRadius.circular(radius),
      elevation: elevation,
      padding: padding,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = \$token.color;
    final effectiveIconSize = iconSize ?? (size * 0.5);
    final effectivePadding = padding ?? EdgeInsets.all(size * 0.25);
    
    Widget iconWidget = icon ?? Icon(
      iconData,
      size: effectiveIconSize,
      color: iconColor ?? colors.onSurface,
    );
    
    Widget frameWidget = Container(
      width: size,
      height: size,
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.surfaceContainerHigh,
        shape: shape,
        borderRadius: shape == BoxShape.circle ? null : (borderRadius ?? BorderRadius.circular(8)),
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
      child: Center(
        child: iconWidget,
      ),
    );
    
    if (onTap != null || onLongPress != null) {
      frameWidget = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: shape == BoxShape.circle 
            ? BorderRadius.circular(size / 2)
            : (borderRadius ?? BorderRadius.circular(8)),
          child: frameWidget,
        ),
      );
    }
    
    return frameWidget;
  }
}

/// Avatar-style icon frame for profile pictures or initials
class AvatarFrame extends IconFrame {
  /// Network image URL for avatar
  final String? imageUrl;
  
  /// Asset image path for avatar
  final String? assetPath;
  
  /// Initials text to display if no image
  final String? initials;
  
  /// Text style for initials
  final TextStyle? initialsStyle;
  
  /// Placeholder widget when image fails to load
  final Widget? placeholder;

  const AvatarFrame({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.initials,
    this.initialsStyle,
    this.placeholder,
    super.size = 48.0,
    super.backgroundColor,
    super.borderColor,
    super.borderWidth,
    super.elevation,
    super.onTap,
    super.onLongPress,
  }) : super(
    iconData: null,
    shape: BoxShape.circle,
  );

  @override
  Widget build(BuildContext context) {
    final colors = \$token.color;
    final textStyles = \$token.textStyle;
    
    Widget avatarContent;
    
    if (imageUrl != null) {
      avatarContent = ClipOval(
        child: Image.network(
          imageUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildFallback(colors, textStyles);
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colors.primary,
              ),
            );
          },
        ),
      );
    } else if (assetPath != null) {
      avatarContent = ClipOval(
        child: Image.asset(
          assetPath!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildFallback(colors, textStyles);
          },
        ),
      );
    } else {
      avatarContent = _buildFallback(colors, textStyles);
    }
    
    Widget frameWidget = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.surfaceContainerHigh,
        shape: BoxShape.circle,
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
      child: avatarContent,
    );
    
    if (onTap != null || onLongPress != null) {
      frameWidget = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(size / 2),
          child: frameWidget,
        ),
      );
    }
    
    return frameWidget;
  }
  
  Widget _buildFallback(dynamic colors, dynamic textStyles) {
    if (placeholder != null) return placeholder!;
    
    if (initials != null && initials!.isNotEmpty) {
      return Center(
        child: Text(
          initials!.toUpperCase(),
          style: initialsStyle ?? textStyles.titleMedium?.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    
    return Center(
      child: Icon(
        Icons.person,
        size: size * 0.5,
        color: colors.onSurface.withOpacity(0.6),
      ),
    );
  }
}
''';
