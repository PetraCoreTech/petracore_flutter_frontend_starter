import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String snackBarHelperTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/core/core.dart';

class SnackBarHelper {
  SnackBarHelper(this.context);
  final BuildContext context;

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({
    required String content,
    double? radius,
    BorderRadiusGeometry? borderRadius,
    TextStyle? contentStyle,
    Duration? duration,
  }) {
    final colors = \$token.color;
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colors.toastInfo.resolve(context),
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: contentStyle ??
              \$token.textStyle.paragraph3.resolve(context).copyWith(
                    color: colors.onToastInfo.resolve(context),
                  ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 8),
        ),
        duration: duration ?? const Duration(milliseconds: 1000),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
''';
