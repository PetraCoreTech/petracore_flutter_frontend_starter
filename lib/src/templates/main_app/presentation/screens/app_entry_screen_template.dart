import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String appEntryScreenTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';

class AppEntryScreen extends StatefulWidget {
  const AppEntryScreen({super.key});

  @override
  State<AppEntryScreen> createState() => _AppEntryScreenState();
}

class _AppEntryScreenState extends State<AppEntryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigate());
  }

  Future<void> _navigate() async {
    context.goNamed(AppRoutes.dashboard.name);
  }

  @override
  Widget build(BuildContext context) {
    return const ScaffoldV1(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
''';
