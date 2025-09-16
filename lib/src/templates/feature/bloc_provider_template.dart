
import '../../generators/feature_generator.dart';

String blocProviderTemplate(FeatureConfig config) => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import '${config.featureName}_cubit.dart';
${config.includeRepository ? "import '../../data/repositories/repositories.dart';" : ''}
${config.includeUseCases ? "import '../../data/use_cases/use_cases.dart';" : ''}

final List<BlocProvider> ${config.camelCase}BlocProvider = [
  BlocProvider<${config.pascalCase}Cubit>(
    create: (context) => ${config.pascalCase}Cubit(
${config.includeUseCases ? '      Get${config.pascalCase}UseCase(${config.pascalCase}RepositoryImpl()),' : ''}
    ),
  ),
];
''';
