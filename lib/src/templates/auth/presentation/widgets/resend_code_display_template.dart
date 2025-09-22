import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String resendCodeDisplayTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/app/app.dart';
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
    final onSurfaceLight = colors.onSurfaceLight.resolve(context);
    final paragraph3 = \$token.textStyle.paragraph3.resolve(context);
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: title ?? 'Can’t fnd your code? Check your spam or ',
        style: paragraph3.copyWith(color: onSurfaceLight),
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
