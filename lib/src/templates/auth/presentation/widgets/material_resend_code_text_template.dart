import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String materialResendCodeTextTemplate(ProjectConfig config) => '''
import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/core/core.dart';

class ResendCodeText extends StatefulWidget {
  const ResendCodeText({
    required this.onResendTap,
    super.key,
    this.count,
  });
  final ValueNotifier<int>? count;
  final VoidCallback onResendTap;

  @override
  State<ResendCodeText> createState() => _ResendCodeTextState();
}

class _ResendCodeTextState extends State<ResendCodeText> {
  late ValueNotifier<int> count;
  late Timer? timer;

  @override
  void initState() {
    super.initState();
    count = widget.count ?? ValueNotifier(40);
    timer = null;
    start();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder<int>(
      valueListenable: count,
      builder: (context, value, _) {
        return RichText(
          text: TextSpan(
            children: [
              if (count.value > 0)
                TextSpan(
                  text: 'Resend otp in \$value sec'.pluralize(count: value),
                  style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1,
                      ),
                )
              else
                TextSpan(
                  text: '<ContentString.resendCode>',
                  style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        height: 1,
                      ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      count.value = 40;
                      start();
                      widget.onResendTap();
                    },
                ),
            ],
          ),
        );
      },
    );
  }

  void start() {
    const interval = Duration(seconds: 1);
    timer = Timer.periodic(interval, (timer) {
      if (count.value <= 0) {
        timer.cancel();
      }
      if (timer.isActive) {
        count.value--;
      }
    });
  }
}
''';
