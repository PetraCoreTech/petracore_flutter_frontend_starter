import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String toastHelperTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:${config.projectName}/core/core.dart';

enum ToastType {error, success, info}


class ToastHelper {
  ToastHelper(this.context);
  
  final BuildContext context;

  ToastFuture showComingSoon() => showToast(content: 'Coming soon...');

  ToastFuture showToast({
    ToastType toastType = ToastType.info,
    String? content,
    bool? showDismiss,
    Duration? duration,
    TextStyle? contentStyle,
    Color? backgroundColor,
    double? radius,
    BoxConstraints? constraints,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
    ToastPosition? position,
    IconData? iconData,
  }) {
    return showToastWidget(
      ToastV1(
        toastType: toastType,
        contentStyle: contentStyle,
        content: content,
        iconData: iconData,
      ),
      context: context,
      duration: duration ?? const Duration(seconds: 2),
      dismissOtherToast: true,
      position: position ??
          const ToastPosition(
            align: Alignment.bottomCenter,
            offset: -8,
          ),
    );
  }
}
''';
