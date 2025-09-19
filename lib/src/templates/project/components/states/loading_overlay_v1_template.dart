import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String loadingOverlayV1Template(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:${config.projectName}/core/core.dart';

class LoadingOverlayV1 extends StatelessWidget {
  const LoadingOverlayV1({
    required this.isLoading,
    required this.child,
    super.key,
    this.color,
  });
  final bool isLoading;
  final Widget child;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      opacity: 0.85,
      color: Colors.black,
      progressIndicator: const LoadingIndicator(),
      child: child,
    );
  }
}
''';
