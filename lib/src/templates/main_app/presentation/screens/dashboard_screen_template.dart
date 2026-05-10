import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String dashboardScreenTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldV1(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.dashboard, size: 64),
              const Gap(16),
              Text(
                'Welcome to ${config.className}!',
                style: \$token.textStyle.heading4.resolve(context),
              ),
              const Gap(8),
              Text(
                'You are logged in.',
                style: \$token.textStyle.paragraph2.resolve(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''';
