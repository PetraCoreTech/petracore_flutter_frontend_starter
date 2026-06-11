import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String resetPasswordScreenTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

class ResetPasswordScreen extends StatefulHookWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late ResetPasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = ResetPasswordController(context);
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
    final pwdVal = useState('');
    final obscureText = useState(true);
    return MultiBlocListener(
      listeners: [
        /// Auth Bloc Listener
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ToastHelper.showError(context, state.error.message);
            } else if (state is AuthConfirmed) {
              ToastHelper.showSuccess(context, 'Your password has been reset!');
              context.goNamed(AppRoutes.login.name);
            }
          },
        ),
      ],
      child: AppScaffold(
        isLoading: state is AuthLoading,
        body: ScreenFrame.unbounded(
          children: [
            Text(
              'Reset Password',
              style: theme.textTheme.titleLarge
                  ?.copyWith(color: theme.colorScheme.onSurface),
            ),
            const Gap(24),
            Form(
              key: controller.formKey,
              child: PasswordField(
                validator: InputFieldValidator.password,
                controller: controller.password,
                onChanged: (value) => pwdVal.value = value,
                obscureText: obscureText,
              ),
            ),
            const Gap(8),
            Align(
              alignment: Alignment.centerLeft,
              child: PasswordStrengthChecker(password: pwdVal.value),
            ),
            const Gap(16),
            PasswordField(
              controller: controller.confirmPassword,
              obscureText: obscureText,
            ),
            const Gap(48),
            AppButton(
              text: 'Create new password',
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              onTap: controller.resetPassword,
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
