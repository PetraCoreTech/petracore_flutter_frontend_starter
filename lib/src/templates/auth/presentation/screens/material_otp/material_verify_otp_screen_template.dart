import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String materialVerifyOtpScreenTemplate(ProjectConfig config) => '''
import 'package:flutter/services.dart';
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  late VerifyOtpController controller;

  @override
  void initState() {
    super.initState();
    controller = VerifyOtpController(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final email = context.watch<EmailCubit>().state;
    final state = context.watch<AuthBloc>().state;
    return MultiBlocListener(
      listeners: [
        /// Auth Bloc Listener
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ToastHelper(context).showToast(
                toastType: ToastType.error,
                content: state.error.message,
              );
            } else if (state is EmailVerified) {
              ToastHelper(context).showToast(
                content: 'Your email has been verified!',
                toastType: ToastType.success,
              );
              // context.goNamed(AppRoutes.signUp.name);
            } else if (state is AuthConfirmed) {
              ToastHelper(context).showToast(content: state.response.message);
            }
          },
        ),
      ],
      child: ScreenFrame.unbounded(
        isLoading: state is AuthLoading,
        appBar: const AppBarV1(),
        children: [
          Text(
            '<ContentString.checkYourEmail>',
            style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onSurface),
          ),
          const Gap(4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Enter the code we just sent to ',
                  style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                TextSpan(
                  text: email,
                  style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface),
                ),
              ],
            ),
          ),
          const Gap(24),
          Form(
            key: controller.formKey,
            child: BaseTextField(
              labelText: ContentStrings.otp,
              validator: InputFieldValidator.otp,
              keyboardType: TextInputType.number,
              controller: controller.otp,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(AppConstants.otpInput),
              ],
              onFieldSubmitted: (_) => controller.verifyOtp(),
            ),
          ),
          const Gap(16),
          ResendCodeDisplay(
            title: 'Didn\u2019t get a code? ',
            target: email,
            count: controller.count,
          ),
          const Gap(48),
          AppButton(
            text: ContentStrings.contd,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            onTap: controller.verifyOtp,
          ),
          const Gap(16),
          Center(
            child: Text(
              'Wrong email? Go back to change it.',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ),
          const Gap(32),
        ],
      ),
    );
  }
}
''';
