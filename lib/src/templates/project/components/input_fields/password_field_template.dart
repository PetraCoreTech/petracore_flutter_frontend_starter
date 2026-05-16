import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String passwordFieldTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';

class PasswordField extends HookWidget {
  const PasswordField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.style,
    this.controller,
    this.enabled,
    this.onChange,
    this.onFieldSubmitted,
    this.placeholder,
    this.validator,
    this.obscureText,
  });

  factory PasswordField.custom({
    String? hintText,
    Widget? suffixIcon,
    TextStyle? style,
    TextEditingController? controller,
    bool? enabled,
    ValueChanged<String>? onChange,
    ValueChanged<String>? onFieldSubmitted,
    String? placeholder,
    ValidatorCallback? validator,
    Color? borderColor,
  }) {
    return _PasswordField(
      style: style,
      borderColor: borderColor,
      onChange: onChange,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      hintText: hintText,
      suffixIcon: suffixIcon,
      validator: validator,
      placeholder: placeholder,
      enabled: enabled,
    );
  }

  final String? hintText;
  final String? placeholder;
  final Widget? suffixIcon;
  final TextStyle? style;
  final bool? enabled;
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onFieldSubmitted;
  final ValidatorCallback? validator;
  final ValueNotifier<bool>? obscureText;

  @override
  Widget build(BuildContext context) {
    final obscureTxt = obscureText ?? useState<bool>(true);
    return BaseTextField(
      maxLines: 1,
      hintText: hintText,
      labelText: 'Password',
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureTxt.value,
      onChange: onChange,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      validator: validator,
      suffixIcon: IconButton(
        onPressed: () => obscureTxt.value = !obscureTxt.value,
        padding: const EdgeInsets.all(16) + const EdgeInsets.only(right: 8),
        icon: Icon(
          obscureTxt.value
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: colors.onSurface.resolve(context),
        ),
      ),
    );
  }
}

class _PasswordField extends PasswordField {
  const _PasswordField({
    super.hintText,
    super.suffixIcon,
    super.style,
    super.controller,
    super.enabled,
    super.onChange,
    super.onFieldSubmitted,
    super.placeholder,
    super.validator,
    this.borderColor,
  });
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final obscureText = useState<bool>(true);
    return BaseTextField(
      borderColor: borderColor,
      maxLines: 1,
      hintText: hintText,
      labelText: 'Password',
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText.value,
      onChange: onChange,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      validator: validator,
      suffixIcon: IconButton(
        onPressed: () => obscureText.value = !obscureText.value,
        padding: const EdgeInsets.all(16) + const EdgeInsets.only(right: 8),
        icon: Icon(
          obscureText.value
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: colors.onSurface.resolve(context),
        ),
      ),
    );
  }
}
''';
