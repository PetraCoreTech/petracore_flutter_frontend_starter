import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String materialResendCodeDisplayTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

class ResendCodeDisplay extends StatelessWidget {
  const ResendCodeDisplay({
    required this.target,
    super.key,
    this.load = true,
    this.title,
    this.count,
    this.authHelper,
  });
  final ValueNotifier<int>? count;
  final String? title;
  final String target;
  final bool load;
  final AuthHelper? authHelper;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: title ?? 'Can\u2019t fnd your code? Check your spam or ',
        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        children: [
          WidgetSpan(
            child: ResendCodeText(
              count: count,
              onResendTap: () => (authHelper ?? AuthHelper(context)).requestOtp(
                target,
                load: load,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
''';
