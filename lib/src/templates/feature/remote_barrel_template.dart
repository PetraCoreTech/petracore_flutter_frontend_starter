
import '../../generators/feature_generator.dart';

String remoteBarrelTemplate(FeatureConfig config) => '''
export '${config.featureName}_repository.dart';
export '${config.featureName}_service.dart';
export 'dto/dto.dart';
''';
