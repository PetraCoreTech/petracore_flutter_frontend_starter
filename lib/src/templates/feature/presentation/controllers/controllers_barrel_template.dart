import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String controllersBarrelTemplate(FeatureConfig config) => '''
export 'cubits/${config.featureName}_cubit.dart';
export 'blocs/${config.featureName}_action_bloc/${config.featureName}_action_bloc.dart';
export 'blocs/multiple_${config.featureName}_bloc/multiple_${config.featureName}_bloc.dart';
export '${config.featureName}_bloc_provider.dart';
''';
