import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String materialForgotPasswordScreenTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late EmailController controller;

  @override
  void initState() {
    super.initState();
    controller = EmailController(context);
    controller.initValues();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<AuthBloc>().state;
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ToastHelper(context).showToast(
                toastType: ToastType.error,
                content: state.error.message,
              );
            } else if (state is AuthConfirmed) {
              ToastHelper(context).showToast(content: state.response.message);
              context.goNamed(AppRoutes.forgotPasswordVerify.name);
            }
          },
        ),
      ],
      child: Form(
        key: controller.formKey,
        child: ScreenFrame.unbounded(
          isLoading: state is AuthLoading,
          appBar: const AppBarV1(),
          children: [
            Text(
              'Forgot password?',
              style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onSurface),
            ),
            const Gap(4),
            Text(
              """Please provide the email address associated with the account you wish to recover. We'll send a recovery code to that email.""",
              style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const Gap(24),
            BaseTextField(
              labelText: ContentStrings.email,
              keyboardType: TextInputType.emailAddress,
              validator: (_) =>
                  InputFieldValidator.requiredEmail(controller.email),
              controller: controller.email,
              onFieldSubmitted: (value) => controller.requestResetOtp(),
            ),
            const Gap(48),
            AppButton(
              text: 'Send code',
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              onTap: controller.requestResetOtp,
            ),
            const Gap(16),
            AppTextButton(
              text: 'Back to login',
            onTap: () {
              context.goNamed(AppRoutes.login.name);
            },
            ),
            const Gap(32),
          ],
        ),
      ),
    );
  }
}
''';
