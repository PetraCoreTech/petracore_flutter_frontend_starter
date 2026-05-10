import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialAppBarV1Template(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';

class AppBarV1 extends StatelessWidget implements PreferredSizeWidget {
  const AppBarV1({
    super.key,
    this.title,
    this.onBackPressed,
    this.hasLeading = true,
    this.centerTitle = false,
    this.leadingWidth,
    this.toolbarHeight,
    this.actions,
    this.leading,
    this.iconData,
    this.shape,
    this.titleAlt,
    this.titleStyle,
    this.backgroundColor,
    this.bottom,
    this.padding,
  });
  final double? leadingWidth;
  final double? toolbarHeight;
  final bool hasLeading;
  final bool centerTitle;
  final String? title;
  final IconData? iconData;
  final Widget? leading;
  final Widget? titleAlt;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final ShapeBorder? shape;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final PreferredSizeWidget? bottom;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surface = backgroundColor ?? theme.appBarTheme.backgroundColor;
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: AppBar(
        backgroundColor: surface,
        surfaceTintColor: surface,
        toolbarHeight: toolbarHeight,
        leadingWidth: hasLeading ? (leadingWidth ?? 48) : 0,
        titleSpacing: 0,
        shape: shape,
        leading: hasLeading
            ? Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (hasLeading)
                    leading ??
                        IconButton(
                          onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                          icon: Icon(
                            iconData ?? Icons.arrow_back_ios,
                            size: 24,
                            color: theme.appBarTheme.iconTheme?.color ?? Colors.black,
                          ),
                        ),
                ],
              )
            : const SizedBox.shrink(),
        title: title != null
            ? Text(
                title!,
                style: titleStyle ?? theme.appBarTheme.titleTextStyle,
              )
            : titleAlt,
        centerTitle: centerTitle,
        bottom: bottom,
        actions: actions ?? [const SizedBox(width: 16)],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}
''';
