import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String dataBlocEventTemplate(FeatureConfig config) => '''
part of 'multiple_${config.featureName}_bloc.dart';

@immutable
sealed class Multiple${config.pascalCase}Event {}

final class FetchMultiple${config.pascalCase} extends Multiple${config.pascalCase}Event {
  FetchMultiple${config.pascalCase}();
}
''';
