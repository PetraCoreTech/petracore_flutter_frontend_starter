import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String dtoBarrelTemplate(FeatureConfig config) => '''
export 'create${config.featureName}_dto.dart';
export 'update${config.featureName}_dto.dart';
export '${config.featureName}_params.dart';
''';
