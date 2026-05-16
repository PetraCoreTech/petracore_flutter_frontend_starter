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
  return DialogHelper<bool>(context).showDialogV1(
    alignment: Alignment.center,
    borderRadius: BorderRadius.circular(12),
    insetPadding: const EdgeInsets.symmetric(horizontal: 24),
    content: ActionDialog(
      title: 'Exit \${AppConstants.appName}?',
      subtitle:
          '''Are you sure you want to exit \${AppConstants.appName}?, Any unsaved changes would be lost.''',
      primaryButtonText: ContentStrings.exit,
      primaryButtonAction: () {
        context.popDialog();
        SystemNavigator.pop();
      },
      secondaryButtonAction: context.popDialog,
    ),
  );
}

""";
