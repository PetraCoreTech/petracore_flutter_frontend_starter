import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String dialogHelperTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog_updated/flutter_animated_dialog.dart';
import 'package:gap/gap.dart';
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/core/components/components_index.dart';

class DialogHelper<T> {
  DialogHelper(this.context);
  final BuildContext context;

  Future<T?> _base(
    WidgetBuilder builder, {
    bool barrierDismissible = false,
    DialogTransitionType? animationType,
  }) =>
      showAnimatedDialog<T>(
        context: context,
        builder: builder,
        curve: Curves.easeIn,
        barrierDismissible: barrierDismissible,
        animationType: animationType ?? DialogTransitionType.slideFromBottom,
      );

  Future<T?> showBlankDialog({
    required Widget child,
    EdgeInsets? insetPadding,
    DialogTransitionType? animationType,
  }) {
    return _base(
      barrierDismissible: true,
      animationType: animationType ?? DialogTransitionType.slideFromBottom,
      (context) => child,
    );
  }

  Future<T?> showDialogV1({
    double? radius,
    bool barrierDismissible = true,
    Color? backgroundColor,
    Widget? title,
    Widget? content,
    List<Widget>? bottom,
    EdgeInsets? insetPadding,
    AlignmentGeometry? alignment,
    BorderRadiusGeometry? borderRadius,
  }) {
    final rad = Radius.circular(radius ?? 8);
    return _base(
      barrierDismissible: barrierDismissible,
      (context) => AlertDialog(
        insetPadding: insetPadding ?? EdgeInsets.zero,
        backgroundColor:
            backgroundColor ?? \$token.color.dialogSurface.resolve(context),
        shape: RoundedRectangleBorder(
          borderRadius:
              borderRadius ?? BorderRadius.only(topLeft: rad, topRight: rad),
        ),
        alignment: alignment ?? Alignment.bottomCenter,
        title: title,
        content: content,
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Future<T?> showBottomSheet({
    double? radius,
    bool enableDrag = true,
    bool barrierDismissible = true,
    bool isScrollControlled = true,
    bool useRootNavigator = true,
    Color? barrierColor,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    List<Widget>? children,
    Widget? child,
  }) {
    final rad = Radius.circular(radius ?? 8);
    return showModalBottomSheet<T>(
      context: context,
      useRootNavigator: useRootNavigator,
      backgroundColor:
          backgroundColor ?? \$token.color.dialogSurface.resolve(context),
      isScrollControlled: isScrollControlled,
      isDismissible: barrierDismissible,
      enableDrag: enableDrag,
      barrierColor: barrierColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ??
            BorderRadius.only(
              topLeft: rad,
              topRight: rad,
            ),
      ),
      builder: (context) {
        final size = MediaQuery.sizeOf(context);
        return SizedBox(
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: DividerV1(
                  width: 66,
                  height: 6,
                  color: MhapyColors.blackLight,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              if (child != null) child else if (children != null) ...children,
              const Gap(16),
            ],
          ),
        );
      },
    );
  }
}
''';
