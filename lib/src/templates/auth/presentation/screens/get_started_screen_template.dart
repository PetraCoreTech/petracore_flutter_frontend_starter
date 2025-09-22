import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String getStartedScreenTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  late EmailController controller;

  @override
  void initState() {
    super.initState();
    controller = EmailController(context)..initValues();
    controller.initValues();
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
        /// Auth Bloc Listener
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ToastHelper(context).showToast(
                toastType: ToastType.error,
                content: state.error.message,
              );
            } else if (state is UserConfirmed) {
              if (state.response.success! == true) {
               // context.goNamed(AppRoutes.login.name);
              } else {
                AuthHelper(context).requestOtp(email);
              }
            } else if (state is AuthConfirmed) {
              ToastHelper(context).showToast(content: state.response.message);
              // context.goNamed(AppRoutes.verifyEmail.name);
            }
          },
        ),
      ],
      child: ScreenFrame.unbounded(
        isLoading: state is AuthLoading,
        appBar: const AppBarV1(),
        children: [
          Text(
            '<ContentString.getStarted>',
            style: heading4.copyWith(color: onSurfaceDark),
          ),
          const Gap(4),
          Text(
            '<ContentString.enterEmail>',
            style: paragraph2.copyWith(color: onSurfaceLight),
          ),
          const Gap(24),
          Form(
            key: controller.formKey,
            child: BaseTextField(
              labelText: ContentStrings.email,
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              validator: (_) => InputFieldValidator.requiredEmail(
                controller.email,
              ),
              onFieldSubmitted: (value) => controller.checkUser(),
              controller: controller.email,
            ),
          ),
          const Gap(48),
          AppButton(
            text: ContentStrings.contd,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            onTap: controller.checkUser,
          ),
          const Gap(32),
        ],
      ),
    );
  }
}
''';
