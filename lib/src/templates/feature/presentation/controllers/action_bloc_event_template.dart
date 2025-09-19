import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String actionBlocEventTemplate(FeatureConfig config) => '''
part of '${config.featureName}_action_bloc.dart';

@immutable
sealed class ${config.pascalCase}ActionEvent {}

final class Create${config.pascalCase} extends ${config.pascalCase}ActionEvent {
  Create${config.pascalCase}();
}

final class Delete${config.pascalCase} extends ${config.pascalCase}ActionEvent {
  Delete${config.pascalCase}(this.id);
  final String id;
}

final class Update${config.pascalCase} extends ${config.pascalCase}ActionEvent {
  Update${config.pascalCase}();
}
''';
