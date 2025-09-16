
import '../../generators/feature_generator.dart';

String dtoBarrelTemplate(FeatureConfig config) => '''
export '${config.featureName}_dto.dart';
''';
