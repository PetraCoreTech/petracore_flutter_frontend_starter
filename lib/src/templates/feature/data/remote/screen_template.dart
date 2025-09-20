import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String screenTemplate(FeatureConfig config) => '''
import 'package:${config.projectConfig.projectName}/core/core.dart';

class ${config.pascalCase}Screen extends StatefulWidget {
  const ${config.pascalCase}Screen({super.key});

  @override
  State<${config.pascalCase}Screen> createState() => _${config.pascalCase}ScreenState();
}

class _${config.pascalCase}ScreenState extends State<${config.pascalCase}Screen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame.unbounded(
      children: const [
        Text('Built with Petracore'),
      ],
    );
  }
  
}
''';
