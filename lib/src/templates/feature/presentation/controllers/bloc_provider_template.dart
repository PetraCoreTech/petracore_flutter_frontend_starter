import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String blocProviderTemplate(FeatureConfig config) => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:${config.projectConfig.projectName}/features/${config.featureName}/presentation/controllers/${config.featureName}_controller_index.dart';

final List<BlocProvider> ${config.camelEntity}BlocProvider = [
  BlocProvider<${config.pascalEntity}ActionBloc>(create: (context) => ${config.camelEntity}ActionBloc),
  BlocProvider<Multiple${config.pascalEntity}Bloc>(create: (context) => multiple${config.pascalEntity}Bloc),
  BlocProvider<${config.pascalEntity}Cubit>(create: (context) => ${config.camelEntity}Cubit),
];
''';
