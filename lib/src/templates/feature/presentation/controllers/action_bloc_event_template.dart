import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String actionBlocEventTemplate(FeatureConfig config) => '''
part of '${config.featureName}_action_bloc.dart';

@immutable
sealed class ${config.pascalEntity}ActionEvent {}

final class Create${config.pascalEntity} extends ${config.pascalEntity}ActionEvent {
  Create${config.pascalEntity}();
}

final class Delete${config.pascalEntity} extends ${config.pascalEntity}ActionEvent {
  Delete${config.pascalEntity}(this.id);
  final String id;
}

final class Update${config.pascalEntity} extends ${config.pascalEntity}ActionEvent {
  Update${config.pascalEntity}({required this.id});
  final String id;
}
''';
