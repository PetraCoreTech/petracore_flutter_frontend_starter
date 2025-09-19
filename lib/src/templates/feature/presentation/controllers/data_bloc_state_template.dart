import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String dataBlocStateTemplate(FeatureConfig config) => '''
part of '${config.featureName}s_bloc.dart';

@immutable
sealed class ${config.pascalCase}sState {}

final class ${config.pascalCase}sInitial extends ${config.pascalCase}sState {}

final class ${config.pascalCase}sLoading extends ${config.pascalCase}sState {}

final class ${config.pascalCase}sLoaded extends ${config.pascalCase}sState {
  ${config.pascalCase}sLoaded(this.${config.camelCase}s);
  final List<${config.pascalCase}> ${config.camelCase}s;
}

final class ${config.pascalCase}sError extends ${config.pascalCase}sState {
  ${config.pascalCase}sError(this.error);
  final ErrorResponse error;
}
''';
