import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String featureIndexTemplate(FeatureConfig config) => '''
${config.includeModels ? "export 'data/models/${config.featureName}_model.dart';" : ''}
${config.includeRepository ? "export 'data/remote/dto/create_${config.featureName}_dto.dart';" : ''}
${config.includeRepository ? "export 'data/remote/dto/update_${config.featureName}_dto.dart';" : ''}
${config.includeRepository ? "export 'data/remote/dto/${config.featureName}_params.dart';" : ''}
${config.includeRepository ? "export 'data/remote/${config.featureName}_service.dart';" : ''}
${config.includeRepository ? "export 'data/remote/${config.featureName}_repository.dart';" : ''}
${config.includeUseCases ? "export 'data/domain/${config.featureName}_use_cases.dart';" : ''}

export 'presentation/presentation.dart';
''';
