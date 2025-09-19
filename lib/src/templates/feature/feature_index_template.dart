import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String featureIndexTemplate(FeatureConfig config) => '''
${config.includeModels ? "export 'data/models/models.dart';" : ''}
${config.includeRepository ? "export 'data/remote/remote.dart';" : ''}
${config.includeUseCases ? "export 'data/domain/${config.featureName}use_cases.dart';" : ''}

export 'presentation/presentation.dart';
''';
