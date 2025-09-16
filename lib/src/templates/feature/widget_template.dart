
import '../../generators/feature_generator.dart';

String widgetTemplate(FeatureConfig config) => '''
import 'package:flutter/material.dart';

class ${config.pascalCase}Widget extends StatelessWidget {
  const ${config.pascalCase}Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${config.className} Widget',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This is a reusable widget for the ${config.featureName} feature.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          // TODO: Add your widget implementation here
        ],
      ),
    );
  }
}
''';
