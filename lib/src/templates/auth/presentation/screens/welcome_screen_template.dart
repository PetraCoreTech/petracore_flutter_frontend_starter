import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String welcomeScreenTemplate(ProjectConfig config) => '''
import 'package:flutter/gestures.dart';
import 'package:${config.projectName}/core/core.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final token = context.\$token;

    return AppScaffold(
      body: ScreenFrame.unbounded(
        useSlivers: true,
        children: [
          SliverToBoxAdapter(
            child: PaddedColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const Gap(62),
                Container(
                  height: size.height * 0.35,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.image,
                    size: 120,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const Gap(32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome!',
                      style: token.textStyle.heading1.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      'Your journey starts here. Sign up or log in to get started and explore amazing features.',
                      style: token.textStyle.body1.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SliverGap(48),
          SliverHelper.fillRemaining(
            child: PaddedColumn(
              mainAxisAlignment: MainAxisAlignment.end,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                AppButton(
                  text: 'Get Started',
                  onTap: () {
                    context.goNamed(AppRoutes.login.name);
                  },
                ),
                const Gap(16),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'By clicking you agree to the ',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    children: [
                      TextSpan(
                        text: 'Terms of Use',
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: theme.colorScheme.primary),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                        text: ' and you acknowledge that you have read ',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: theme.colorScheme.primary),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                        text: '.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
''';
