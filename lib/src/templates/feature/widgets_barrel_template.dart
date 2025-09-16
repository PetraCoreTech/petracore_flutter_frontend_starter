import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String widgetsBarrelTemplate(FeatureConfig config) => '''
export '${config.featureName}_widget.dart';
''';
