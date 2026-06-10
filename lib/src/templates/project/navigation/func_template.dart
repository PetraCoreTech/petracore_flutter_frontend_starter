import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String funcTemplate(ProjectConfig config) => """
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:${config.projectName}/core/core.dart';

FutureOr<bool> goHome(BuildContext context) {
  context.goNamed(AppRoutes.dashboard.name);
  return false;
}

FutureOr<bool?> showExitDialog(BuildContext context) {
 return DialogHelper.showActionDialog(
    context: context,
    dialog: ActionDialog(
      title: 'Exit \${AppConstants.appName}?',
      subtitle:
          '''Are you sure you want to exit \${AppConstants.appName}?, Any unsaved changes would be lost.''',
      primaryText: ContentStrings.exit,
      onPrimary: () {
        context.popDialog();
        SystemNavigator.pop();
      },
      onSecondary: context.popDialog,
    ),
  );
}
""";
