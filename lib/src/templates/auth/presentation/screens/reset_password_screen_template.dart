import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String resetPasswordScreenTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';
import 'package:${config.projectName}/navigation/navigation_index.dart';

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
    final onSurfaceDark = colors.onSurfaceDark.resolve(context);
    final onSurfaceLight = colors.onSurfaceLight.resolve(context);
    final heading4 = \$token.textStyle.heading4.resolve(context);
    final paragraph2 = \$token.textStyle.paragraph2.resolve(context);
    final state = context.watch<AuthBloc>().state;
    final pwdVal = useState('');
    final obscureText = useState(true);
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
            } else if (state is AuthConfirmed) {
              ToastHelper(context).showToast(
                content: 'Your password has been reset!',
                toastType: ToastType.success,
              );
              // context.goNamed(AppRoutes.login.name);
            }
          },
        ),
      ],
      child: ScreenFrame.unbounded(
        isLoading: state is AuthLoading,
        children: [
          Text(
            '<ContentString.enterNewPwd>',
            style: heading4.copyWith(color: onSurfaceDark),
          ),
          const Gap(4),
          Text(
            '<ContentString.createANewPwd>',
            style: paragraph2.copyWith(color: onSurfaceLight),
          ),
          const Gap(24),
          Form(
            key: controller.formKey,
            child: PasswordField(
              validator: InputFieldValidator.password,
              controller: controller.password,
              onChange: (value) => pwdVal.value = value,
              obscureText: obscureText,
            ),
          ),
          const Gap(8),
          Align(
            alignment: Alignment.centerLeft,
            child: PasswordStrengthChecker(
              password: pwdVal,
              activeIconData: Icons.check,
              inactiveIconData: Icons.check,
              activeColor: colors.primaryDark.resolve(context),
              inactiveColor: colors.border.resolve(context),
            ),
          ),
          const Gap(16),
          PasswordField(
            controller: controller.confirmPassword,
            obscureText: obscureText,
          ),
          const Gap(48),
          AppButton(
            text: '<ContentString.createNewPwd>',
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            onTap: controller.resetPassword,
          ),
          const Gap(16),
          AppTextButton(
            text: '<ContentString.backToLogin>',
            onTap: () {},
          ),
          const Gap(32),
        ],
      ),
    );
  }
}
''';
