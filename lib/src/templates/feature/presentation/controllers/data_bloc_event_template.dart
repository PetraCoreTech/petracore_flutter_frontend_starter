import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String dataBlocEventTemplate(FeatureConfig config) => '''
part of '${config.featureName}_bloc.dart';

@immutable
sealed class ${config.pascalCase}Event {}

final class Fetch${config.pascalCase}s extends ${config.pascalCase}Event {
  Fetch${config.pascalCase}s();
}
''';
