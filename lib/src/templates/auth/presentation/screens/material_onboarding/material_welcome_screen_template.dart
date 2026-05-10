import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String materialWelcomeScreenTemplate(ProjectConfig config) => '''
import 'package:flutter/gestures.dart';
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';
import 'package:${config.projectName}/navigation/navigation_index.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return ScreenFrame.unbounded(    
      useSlivers: true,
      children: [
      SliverToBoxAdapter(
          child: PaddedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const Gap(24),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.flutter_dash,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const Gap(24),
              // Welcome Image/Illustration
              Container(
                height: size.height * 0.35,
                width: size.width,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outline,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.phone_android,
                  size: 120,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const Gap(16),
              // Welcome Text
              Text(
                'Welcome to ${config.className}!',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(8),
              Text(
                'Your journey starts here. Sign up or log in to get started and explore amazing features.',
                style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SliverGap(48),
        SliverHelper.buildSliverFillRemaining(
          child: PaddedColumn(
            mainAxisAlignment: MainAxisAlignment.end,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              AppButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                text: '<ContentString.getStarted>',
                onTap: () {
                  context.goNamed(AppRoutes.login.name);
                },
              ),
              const Gap(16),
              RichText(
                text: TextSpan(
                  text: 'By clicking you agree to the ',
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  children: [
                    TextSpan(
                      text: 'Terms of Use',
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                        },
                    ),
                    TextSpan(
                      text: ' and you acknowledge that you have read ',
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                        },
                    ),
                    TextSpan(
                      text: '.',
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              const Gap(32),
            ],
          ),
        ),
      ],
    );
  }
}
''';
