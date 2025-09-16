
import '../../generators/feature_generator.dart';

String modelsBarrelTemplate(FeatureConfig config) => '''
export '${config.featureName}_model.dart';
''';
