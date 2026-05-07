import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialLoadingShimmerTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.child,
    this.shape,
  });
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final Widget? child;
  final BoxShape? shape;

  @override
  Widget build(BuildContext context) {
    final boxShape = shape ?? BoxShape.rectangle;
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: boxShape == BoxShape.rectangle
            ? borderRadius ?? BorderRadius.circular(24)
            : null,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        shape: boxShape,
      ),
      child: child,
    );
  }
}
''';
