import '../../../generators/project_generator.dart';

String profileframeTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import '../../theme/design_tokens/theme_token.dart';
import 'icon_frame.dart';

/// Profile frame component with consistent styling for ${config.projectName}
/// 
/// A reusable frame for displaying profile information with avatar, details, and actions.
/// Provides consistent styling for user profile presentations.
class ProfileFrame extends StatelessWidget {
  /// Profile avatar image URL
  final String? avatarUrl;
  
  /// Profile avatar asset path
  final String? avatarAsset;
  
  /// User initials for avatar fallback
  final String? initials;
  
  /// User name
  final String? name;
  
  /// User subtitle/description
  final String? subtitle;
  
  /// Additional details to display
  final String? details;
  
  /// Custom content widget
  final Widget? customContent;
  
  /// Action buttons or widgets
  final List<Widget>? actions;
  
  /// Avatar size
  final double avatarSize;
  
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
  
  /// Whether to show avatar
  final bool showAvatar;
  
  /// Avatar tap callback
  final VoidCallback? onAvatarTap;
  
  /// Profile tap callback
  final VoidCallback? onTap;
  
  /// Profile layout direction
  final ProfileLayout layout;

  /// Constructor
  const ProfileFrame({
    super.key,
    this.avatarUrl,
    this.avatarAsset,
    this.initials,
    this.name,
    this.subtitle,
    this.details,
    this.customContent,
    this.actions,
    this.avatarSize = 48.0,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.borderRadius,
    this.margin,
    this.padding,
    this.elevation = 0,
    this.showAvatar = true,
    this.onAvatarTap,
    this.onTap,
    this.layout = ProfileLayout.horizontal,
  });
  
  /// Factory constructor for horizontal card layout
  factory ProfileFrame.card({
    Key? key,
    String? avatarUrl,
    String? avatarAsset,
    String? initials,
    String? name,
    String? subtitle,
    String? details,
    List<Widget>? actions,
    double avatarSize = 56.0,
    EdgeInsets? margin,
    EdgeInsets? padding,
    double elevation = 2,
    VoidCallback? onAvatarTap,
    VoidCallback? onTap,
  }) {
    return ProfileFrame(
      key: key,
      avatarUrl: avatarUrl,
      avatarAsset: avatarAsset,
      initials: initials,
      name: name,
      subtitle: subtitle,
      details: details,
      actions: actions,
      avatarSize: avatarSize,
      margin: margin ?? const EdgeInsets.all(16),
      padding: padding ?? const EdgeInsets.all(16),
      elevation: elevation,
      borderRadius: BorderRadius.circular(12),
      onAvatarTap: onAvatarTap,
      onTap: onTap,
      layout: ProfileLayout.horizontal,
    );
  }
  
  /// Factory constructor for vertical centered layout
  factory ProfileFrame.centered({
    Key? key,
    String? avatarUrl,
    String? avatarAsset,
    String? initials,
    String? name,
    String? subtitle,
    String? details,
    List<Widget>? actions,
    double avatarSize = 80.0,
    EdgeInsets? margin,
    EdgeInsets? padding,
    double elevation = 2,
    VoidCallback? onAvatarTap,
    VoidCallback? onTap,
  }) {
    return ProfileFrame(
      key: key,
      avatarUrl: avatarUrl,
      avatarAsset: avatarAsset,
      initials: initials,
      name: name,
      subtitle: subtitle,
      details: details,
      actions: actions,
      avatarSize: avatarSize,
      margin: margin ?? const EdgeInsets.all(16),
      padding: padding ?? const EdgeInsets.all(24),
      elevation: elevation,
      borderRadius: BorderRadius.circular(16),
      onAvatarTap: onAvatarTap,
      onTap: onTap,
      layout: ProfileLayout.vertical,
    );
  }
  
  /// Factory constructor for minimal layout
  factory ProfileFrame.minimal({
    Key? key,
    String? avatarUrl,
    String? avatarAsset,
    String? initials,
    String? name,
    String? subtitle,
    double avatarSize = 40.0,
    EdgeInsets? padding,
    VoidCallback? onAvatarTap,
    VoidCallback? onTap,
  }) {
    return ProfileFrame(
      key: key,
      avatarUrl: avatarUrl,
      avatarAsset: avatarAsset,
      initials: initials,
      name: name,
      subtitle: subtitle,
      avatarSize: avatarSize,
      padding: padding ?? const EdgeInsets.all(12),
      onAvatarTap: onAvatarTap,
      onTap: onTap,
      layout: ProfileLayout.horizontal,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = \$token.color;
    final textStyles = \$token.textStyle;
    
    Widget content;
    
    if (customContent != null) {
      content = customContent!;
    } else {
      switch (layout) {
        case ProfileLayout.horizontal:
          content = _buildHorizontalLayout(colors, textStyles);
          break;
        case ProfileLayout.vertical:
          content = _buildVerticalLayout(colors, textStyles);
          break;
      }
    }
    
    Widget frame = Container(
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
      padding: padding ?? const EdgeInsets.all(12),
      child: content,
    );
    
    if (onTap != null) {
      frame = InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        child: frame,
      );
    }
    
    if (margin != null) {
      frame = Padding(
        padding: margin!,
        child: frame,
      );
    }
    
    return frame;
  }
  
  Widget _buildHorizontalLayout(dynamic colors, dynamic textStyles) {
    return Row(
      children: [
        // Avatar
        if (showAvatar)
          AvatarFrame(
            imageUrl: avatarUrl,
            assetPath: avatarAsset,
            initials: initials,
            size: avatarSize,
            onTap: onAvatarTap,
            elevation: 1,
          ),
        
        if (showAvatar) const SizedBox(width: 12),
        
        // Profile info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (name != null)
                Text(
                  name!,
                  style: textStyles.titleMedium?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              
              if (subtitle != null) ..[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: textStyles.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              
              if (details != null) ..[
                const SizedBox(height: 4),
                Text(
                  details!,
                  style: textStyles.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant.withOpacity(0.8),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
        
        // Actions
        if (actions != null && actions!.isNotEmpty) ..[
          const SizedBox(width: 8),
          ...actions!,
        ],
      ],
    );
  }
  
  Widget _buildVerticalLayout(dynamic colors, dynamic textStyles) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar
        if (showAvatar)
          AvatarFrame(
            imageUrl: avatarUrl,
            assetPath: avatarAsset,
            initials: initials,
            size: avatarSize,
            onTap: onAvatarTap,
            elevation: 2,
          ),
        
        if (showAvatar) const SizedBox(height: 16),
        
        // Profile info
        if (name != null)
          Text(
            name!,
            style: textStyles.titleLarge?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        
        if (subtitle != null) ..[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: textStyles.bodyLarge?.copyWith(
              color: colors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        
        if (details != null) ..[
          const SizedBox(height: 8),
          Text(
            details!,
            style: textStyles.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        
        // Actions
        if (actions != null && actions!.isNotEmpty) ..[
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: actions!,
          ),
        ],
      ],
    );
  }
}

/// Profile layout options
enum ProfileLayout {
  /// Horizontal layout with avatar on the left
  horizontal,
  
  /// Vertical layout with centered content
  vertical,
}

/// Compact profile tile for lists
class ProfileTile extends StatelessWidget {
  /// Profile avatar image URL
  final String? avatarUrl;
  
  /// Profile avatar asset path
  final String? avatarAsset;
  
  /// User initials for avatar fallback
  final String? initials;
  
  /// User name
  final String name;
  
  /// User subtitle/description
  final String? subtitle;
  
  /// Leading widget (overrides avatar if provided)
  final Widget? leading;
  
  /// Trailing widget
  final Widget? trailing;
  
  /// Avatar size
  final double avatarSize;
  
  /// Tile tap callback
  final VoidCallback? onTap;
  
  /// Tile long press callback
  final VoidCallback? onLongPress;
  
  /// Content padding
  final EdgeInsets? contentPadding;

  const ProfileTile({
    super.key,
    this.avatarUrl,
    this.avatarAsset,
    this.initials,
    required this.name,
    this.subtitle,
    this.leading,
    this.trailing,
    this.avatarSize = 40.0,
    this.onTap,
    this.onLongPress,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final colors = \$token.color;
    final textStyles = \$token.textStyle;
    
    Widget leadingWidget = leading ?? AvatarFrame(
      imageUrl: avatarUrl,
      assetPath: avatarAsset,
      initials: initials,
      size: avatarSize,
    );
    
    return ListTile(
      contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: leadingWidget,
      title: Text(
        name,
        style: textStyles.titleMedium?.copyWith(
          color: colors.onSurface,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: subtitle != null ? Text(
        subtitle!,
        style: textStyles.bodyMedium?.copyWith(
          color: colors.onSurfaceVariant,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ) : null,
      trailing: trailing,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
''';
