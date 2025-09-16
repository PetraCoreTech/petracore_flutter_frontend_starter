
import '../../generators/feature_generator.dart';

String presentationBarrelTemplate(FeatureConfig config) => '''
export 'screens/screens.dart';
export 'widgets/widgets.dart';
${config.includeBloc ? "export 'controllers/controllers.dart';" : ''}
''';
