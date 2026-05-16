import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String projectBlocProviderTemplate(ProjectConfig config) => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:${config.packageName}/features/main_app/presentation/controllers/main_app_controller_index.dart';

final List<BlocProvider> blocProviders = [
  ...mainAppBlocProvider,
  // petracore:start:bloc_providers
  // petracore:end:bloc_providers
];
''';
