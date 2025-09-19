import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String modelsBarrelTemplate(FeatureConfig config) => '''
export '${config.featureName}_model.dart';
''';
