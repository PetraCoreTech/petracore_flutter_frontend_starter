import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String dataBlocStateTemplate(FeatureConfig config) => '''
part of 'multiple_${config.featureName}_bloc.dart';

@immutable
sealed class Multiple${config.pascalEntity}State {}

final class Multiple${config.pascalEntity}Initial extends Multiple${config.pascalEntity}State {}

final class Multiple${config.pascalEntity}Loading extends Multiple${config.pascalEntity}State {}

final class Multiple${config.pascalEntity}Loaded extends Multiple${config.pascalEntity}State {
  Multiple${config.pascalEntity}Loaded(this.${config.camelEntity}s);
  final List<${config.pascalEntity}> ${config.camelEntity}s;
}

final class Multiple${config.pascalEntity}Error extends Multiple${config.pascalEntity}State {
  Multiple${config.pascalEntity}Error(this.error);
  final ErrorResponse error;
}
''';
