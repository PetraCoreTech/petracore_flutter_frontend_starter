import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String loginScreenTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = LoginController(context)..initValues();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onSurfaceDark = colors.onSurfaceDark.resolve(context);
    final heading4 = \$token.textStyle.heading4.resolve(context);
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
            } else if (state is UserLoggedIn) {
              // AuthHelper(context).login(state.user);
            }
          },
        ),
      ],
      child: ScreenFrame.unbounded(
        isLoading: state is AuthLoading,
        appBar: const AppBarV1(),
        children: [
          Text(
            ContentStrings.login,
            style: heading4.copyWith(color: onSurfaceDark),
          ),
        //  const Gap(4),
         // Text(
          //  ContentString.enterPwdIns,
          //  style: paragraph2.copyWith(color: onSurfaceLight),
         // ),
         // const Gap(24),
           Form(
            key: controller.formKey,
            child: Column(
              children: [
                 BaseTextField(
                    labelText: ContentStrings.email,
                    controller: controller.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (_) => InputFieldValidator.requiredEmail(controller.email),
                    textInputAction: TextInputAction.next,
                  ),
                  const Gap(16),
                PasswordField(
                  validator: InputFieldValidator.required,
                  controller: controller.password,
                  onFieldSubmitted: (value) => controller.login(),
                ),
              ],
            ),
          ),
          const Gap(8),
          Align(
            alignment: Alignment.centerLeft,
            child: HyperLinkText(
              text: 'Forgot Password?',
              onTap: () {},
            ),
          ),
          const Gap(48),
          AppButton(
            text: ContentStrings.login,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            onTap: controller.login,
          ),
          const Gap(32),
        ],
      ),
    );
  }
}
''';
