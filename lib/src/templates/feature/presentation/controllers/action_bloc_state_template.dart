import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String actionBlocStateTemplate(FeatureConfig config) => '''
part of '${config.featureName}_action_bloc.dart';

@immutable
sealed class ${config.pascalCase}ActionState {}

final class ${config.pascalCase}ActionInitial extends ${config.pascalCase}ActionState {}

final class ${config.pascalCase}ActionLoading extends ${config.pascalCase}ActionState {}

final class ${config.pascalCase}Created extends ${config.pascalCase}ActionState {
  ${config.pascalCase}Created(this.${config.camelCase});
  final ${config.pascalCase} ${config.camelCase};
}

final class ${config.pascalCase}Deleted extends ${config.pascalCase}ActionState {
  ${config.pascalCase}Deleted(this.response);
  final SuccessResponse response;
}

final class ${config.pascalCase}Updated extends ${config.pascalCase}ActionState {
  ${config.pascalCase}Updated(this.${config.camelCase});
  final ${config.pascalCase} ${config.camelCase};
}

final class ${config.pascalCase}ActionError extends ${config.pascalCase}ActionState {
  ${config.pascalCase}ActionError(this.error);
  final ErrorResponse error;
}
''';
