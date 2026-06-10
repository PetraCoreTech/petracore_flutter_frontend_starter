import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String materialSignupScreenTemplate(ProjectConfig config) => '''
import 'package:flutter/gestures.dart';
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

class SignupScreen extends StatefulHookWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late SignupController controller;

  @override
  void initState() {
    super.initState();
    controller = SignupController(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final password = useState('');
    final state = context.watch<AuthBloc>().state;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ToastHelper.showError(context, state.error.message);
        } else if (state is UserRegistered) {
          AuthHelper(context).login(state.user, AppRoutes.dashboard);
        }
      },
      child: AppScaffold(
        isLoading: state is AuthLoading,
        appBar: const AppBarV1(),
        body: ScreenFrame.unbounded(
          child: Column(
            children: [
              Text(
                'Signup',
                style: theme.textTheme.titleLarge
                    ?.copyWith(color: theme.colorScheme.onSurface),
              ),
              const Gap(24),
              Form(
                key: controller.formKey,
                child: SeparatedColumn(
                  separatorBuilder: () => const Gap(16),
                  children: [
                    BaseTextField(
                      labelText: ContentStrings.firstname,
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      validator: InputFieldValidator.required,
                      controller: controller.firstname,
                    ),
                    BaseTextField(
                      labelText: ContentStrings.lastname,
                      maxLines: 1,
                      keyboardType: TextInputType.name,
                      validator: InputFieldValidator.required,
                      textInputAction: TextInputAction.next,
                      controller: controller.lastname,
                    ),
                    BaseTextField(
                      labelText: ContentStrings.email,
                      controller: controller.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: InputFieldValidator.email,
                      textInputAction: TextInputAction.next,
                    ),
                    PasswordField(
                      validator: InputFieldValidator.password,
                      controller: controller.password,
                      onChanged: (value) => password.value = value,
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Align(
                alignment: Alignment.centerLeft,
                child: PasswordStrengthChecker(
                  password: password.value,
                ),
              ),
              const Gap(48),
              AppButton(
                text: 'Create Account',
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                onTap: controller.signup,
              ),
              const Gap(24),
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  children: [
                    TextSpan(
                      text: 'Log in',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.goNamed(AppRoutes.login.name),
                    ),
                  ],
                ),
              ),
              const Gap(32),
            ],
          ),
        ),
      ),
    );
  }
}
''';
