import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String dataBlocStateTemplate(FeatureConfig config) => '''
part of 'multiple_${config.featureName}_bloc.dart';

@immutable
sealed class Multiple${config.pascalCase}State {}

final class Multiple${config.pascalCase}Initial extends Multiple${config.pascalCase}State {}

final class Multiple${config.pascalCase}Loading extends Multiple${config.pascalCase}State {}

final class Multiple${config.pascalCase}Loaded extends Multiple${config.pascalCase}State {
  Multiple${config.pascalCase}Loaded(this.${config.camelCase}s);
  final List<${config.pascalCase}> ${config.camelCase}s;
}

final class Multiple${config.pascalCase}Error extends Multiple${config.pascalCase}State {
  Multiple${config.pascalCase}Error(this.error);
  final ErrorResponse error;
}
''';
