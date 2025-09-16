
import '../../generators/feature_generator.dart';

String useCasesBarrelTemplate(FeatureConfig config) => '''
export 'get_${config.featureName}_use_case.dart';
''';
