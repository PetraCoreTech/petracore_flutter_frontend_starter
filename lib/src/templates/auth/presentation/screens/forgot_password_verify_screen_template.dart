import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String forgotPwdVerifyScreenTemplate(ProjectConfig config) => '''
import 'package:flutter/services.dart';
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';
import 'package:${config.projectName}/navigation/navigation_index.dart';

class ForgotPasswordVerifyScreen extends StatefulWidget {
  const ForgotPasswordVerifyScreen({super.key});

  @override
  State<ForgotPasswordVerifyScreen> createState() =>
      _ForgotPasswordVerifyScreenState();
}

class _ForgotPasswordVerifyScreenState
    extends State<ForgotPasswordVerifyScreen> {
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
    final onSurfaceDark = colors.onSurfaceDark.resolve(context);
    final onSurfaceLight = colors.onSurfaceLight.resolve(context);
    final heading4 = \$token.textStyle.heading4.resolve(context);
    final paragraph2 = \$token.textStyle.paragraph2.resolve(context);
    final email = context.watch<EmailCubit>().state;
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
            } else if (state is EmailVerified) {
              context.goNamed(AppRoutes.resetPassword.name);
            } else if (state is AuthConfirmed) {
              ToastHelper(context).showToast(content: state.response.message);
            }
          },
        ),
      ],
      child: ScreenFrame.unbounded(
        isLoading: state is AuthLoading,
        appBar: const AppBarV1(),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Check your email',
            style: heading4.copyWith(color: onSurfaceDark),
          ),
          const Gap(4),
          Text(
            """Enter the code we sent to your email below to proceed with resetting your password.""",
            style: paragraph2.copyWith(color: onSurfaceLight),
          ),
          const Gap(24),
          Form(
            key: controller.formKey,
            child: BaseTextField(
              labelText: ContentStrings.otp,
              keyboardType: TextInputType.number,
              validator: InputFieldValidator.otp,
              controller: controller.otp,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(AppConstants.otpInput),
              ],
              onFieldSubmitted: (_) => controller.verifyOtp(),
            ),
          ),
          const Gap(16),
          Align(
            alignment: Alignment.centerLeft,
            child: ResendCodeDisplay(
              target: email,
              title: 'Didn’t get a code? ',
              count: controller.count,
            ),
          ),
          const Gap(48),
          AppButton(
            text: ContentStrings.confirm,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            onTap: controller.verifyOtp,
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
    );
  }
}
''';
