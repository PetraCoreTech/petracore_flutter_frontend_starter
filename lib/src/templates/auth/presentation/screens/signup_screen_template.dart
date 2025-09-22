import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String signupScreenTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';
import 'package:${config.projectName}/navigation/navigation_index.dart';

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
    final heading4 = \$token.textStyle.heading4.resolve(context);
    final onSurfaceDark = colors.onSurfaceDark.resolve(context);
    final password = useState('');
    final state = context.watch<AuthBloc>().state;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
             ToastHelper(context).showToast(
                toastType: ToastType.error,
                content: state.error.message,
              );
        } else if (state is UserRegistered) {
           // AuthHelper(context).login(state.user);
        }
      },
      child: ScreenFrame.unbounded(
       isLoading: state is AuthLoading,
        appBar: const AppBarV1(),
        children: [
          Text(
            'Signup',
            style: heading4.copyWith(color: onSurfaceDark),
          ),
          // const Gap(4),
          // Text(
            // ContentString.urAccntInfoSub,
            // style: paragraph2.copyWith(color: onSurfaceLight),
          // ),
          // const Gap(24),
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
                  onChange: (value) => password.value = value,
                ),
              ],
            ),
          ),
          const Gap(8),
          Align(
            alignment: Alignment.centerLeft,
            child: PasswordStrengthChecker(
              password: password,
              activeIconData: Icons.check,
              inactiveIconData: Icons.check,
              activeColor: colors.primaryDark.resolve(context),
              inactiveColor: colors.border.resolve(context),
            ),
          ),
          const Gap(48),
          AppButton(
            text: '<ContentString.createAccount>',
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            onTap: controller.signup,
          ),
          const Gap(32),
        ],
      ),
    );
  }
}
''';
