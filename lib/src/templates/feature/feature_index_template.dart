
import '../../generators/feature_generator.dart';

String featureIndexTemplate(FeatureConfig config) => '''
// Data Layer
${config.includeModels ? "export 'data/models/models.dart';" : ''}
${config.includeRepository ? "export 'data/remote/remote.dart';" : ''}
${config.includeUseCases ? "export 'data/use_cases/use_cases.dart';" : ''}

// Presentation Layer
export 'presentation/presentation.dart';
''';
