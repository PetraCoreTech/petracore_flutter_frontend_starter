import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String featureIndex(FeatureConfig config) => '''
// Data Layer
${config.includeModels ? "export 'data/models/models.dart';" : ''}
${config.includeRepository ? "export 'data/remote/remote.dart';" : ''}
${config.includeUseCases ? "export 'data/use_cases/use_cases.dart';" : ''}

// Presentation Layer
export 'presentation/presentation.dart';
''';
