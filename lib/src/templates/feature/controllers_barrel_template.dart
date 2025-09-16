
import '../../generators/feature_generator.dart';

String controllersBarrelTemplate(FeatureConfig config) => '''
export '${config.featureName}_cubit.dart';
export '${config.featureName}_state.dart';
export '${config.featureName}_bloc_provider.dart';
''';
