import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String actionBlocStateTemplate(FeatureConfig config) => '''
part of '${config.featureName}_action_bloc.dart';

@immutable
sealed class ${config.pascalEntity}ActionState {}

final class ${config.pascalEntity}ActionInitial extends ${config.pascalEntity}ActionState {}

final class ${config.pascalEntity}ActionLoading extends ${config.pascalEntity}ActionState {}

final class ${config.pascalEntity}Created extends ${config.pascalEntity}ActionState {
  ${config.pascalEntity}Created(this.${config.camelEntity});
  final ${config.pascalEntity} ${config.camelEntity};
}

final class ${config.pascalEntity}Deleted extends ${config.pascalEntity}ActionState {
  ${config.pascalEntity}Deleted(this.response);
  final SuccessResponse response;
}

final class ${config.pascalEntity}Updated extends ${config.pascalEntity}ActionState {
  ${config.pascalEntity}Updated(this.${config.camelEntity});
  final ${config.pascalEntity} ${config.camelEntity};
}

final class ${config.pascalEntity}ActionError extends ${config.pascalEntity}ActionState {
  ${config.pascalEntity}ActionError(this.error);
  final ErrorResponse error;
}
''';
