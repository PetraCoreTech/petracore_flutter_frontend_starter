import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String dataBlocEventTemplate(FeatureConfig config) => '''
part of 'multiple_${config.featureName}_bloc.dart';

@immutable
sealed class Multiple${config.pascalEntity}Event {}

final class FetchMultiple${config.pascalEntity} extends Multiple${config.pascalEntity}Event {
  FetchMultiple${config.pascalEntity}();
}
''';
