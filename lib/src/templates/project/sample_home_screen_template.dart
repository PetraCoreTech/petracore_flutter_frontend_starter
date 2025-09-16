
import '../../generators/project_generator.dart';

String sampleHomeScreenTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBarV1(
        title: '${config.className}',
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              context.showSnackBar('Notifications feature coming soon!');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              context.showSnackBar('Settings feature coming soon!');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flutter_dash,
              size: 100,
              color: context.colorScheme.primary,
            ),
            const Gap(24),
            Text(
              'Welcome to ${config.className}',
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(16),
            Text(
              'Built with PetraCore Flutter Frontend Starter',
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(32),
            AppButton(
              text: 'Get Started',
              onPressed: () {
                context.showSnackBar('Ready to build amazing features!');
              },
            ),
          ],
        ),
      ),
    );
  }
}
''';
