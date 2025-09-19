import '../../../../generators/feature_generator.dart';

String repositoriesBarrelTemplate(FeatureConfig config) => '''
export '${config.featureName}_repository.dart';
''';
