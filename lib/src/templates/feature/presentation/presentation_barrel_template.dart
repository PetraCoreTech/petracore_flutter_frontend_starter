import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String presentationBarrelTemplate(FeatureConfig config) => '''
export 'screens/${config.featureName}_screens_index.dart';
${config.includeBloc ? "export 'controllers/${config.featureName}_controller_index.dart';" : ''}
''';
