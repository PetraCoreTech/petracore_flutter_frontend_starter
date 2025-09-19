import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String presentationBarrelTemplate(FeatureConfig config) => '''
export 'screens/${config.featureName}screens_index.dart';
${config.includeBloc ? "export 'controllers/controller_index.dart';" : ''}
''';
