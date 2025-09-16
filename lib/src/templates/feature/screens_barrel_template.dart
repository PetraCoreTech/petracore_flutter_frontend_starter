
import '../../generators/feature_generator.dart';

String screensBarrelTemplate(FeatureConfig config) => '''
export '${config.featureName}_screen.dart';
''';
