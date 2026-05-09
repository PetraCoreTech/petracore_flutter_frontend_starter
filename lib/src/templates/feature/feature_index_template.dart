import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String featureIndexTemplate(FeatureConfig config) => '''
${config.includeModels ? "export 'data/models/${config.entityName}_model.dart';" : ''}
${config.includeRepository ? "export 'data/remote/dto/create_${config.entityName}_dto.dart';" : ''}
${config.includeRepository ? "export 'data/remote/dto/update_${config.entityName}_dto.dart';" : ''}
${config.includeRepository ? "export 'data/remote/dto/${config.entityName}_params.dart';" : ''}
${config.includeRepository ? "export 'data/remote/${config.serviceName}.dart';" : ''}
${config.includeRepository ? "export 'data/remote/${config.repositoryName}.dart';" : ''}
${config.includeUseCases ? "export 'data/domain/${config.featureName}_use_cases.dart';" : ''}

export 'presentation/presentation.dart';
''';
