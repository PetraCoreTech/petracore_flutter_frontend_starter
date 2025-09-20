import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String blocProviderTemplate(FeatureConfig config) => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:${config.projectConfig.projectName}/features/${config.featureName}/presentation/controllers/${config.featureName}_controller_index.dart';

final List<BlocProvider> ${config.camelCase}BlocProvider = [
  BlocProvider<${config.pascalCase}ActionBloc>(create: (context) => ${config.camelCase}ActionBloc),
  BlocProvider<Multiple${config.pascalCase}Bloc>(create: (context) => multiple${config.pascalCase}Bloc),
  BlocProvider<${config.pascalCase}Cubit>(create: (context) => ${config.camelCase}Cubit),
];
''';
