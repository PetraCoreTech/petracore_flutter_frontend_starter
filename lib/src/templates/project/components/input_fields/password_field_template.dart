import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String passwordFieldTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:${config.projectName}/app/app/theme/color_values.dart';
import 'package:${config.projectName}/core/components/components_index.dart';

class PasswordField extends HookWidget {
  const PasswordField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.style,
    this.controller,
    this.enabled,
    this.onChange,
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
    String? placeholder,
    ValidatorCallback? validator,
    Color? borderColor,
  }) {
    return _PasswordField(
      style: style,
      borderColor: borderColor,
      onChange: onChange,
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
  final ValidatorCallback? validator;
  final ValueNotifier<bool>? obscureText;

  @override
  Widget build(BuildContext context) {
    final obscureTxt = obscureText ?? useState<bool>(true);
    final colors = \$token.color;
    return BaseTextField(
      prefixIcon: const Padding(
        padding: EdgeInsets.only(left: 16),
        child: Icon(
          Icons.lock_outline_rounded,
          color: colors.onSurface.resolve(context),
        ),
      ),
      maxLines: 1,
      hintText: hintText,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureTxt.value,
      onChange: onChange,
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
    super.placeholder,
    super.validator,
    this.borderColor,
  });
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final obscureText = useState<bool>(true);
    final colors = \$token.color;
    return InputField(
      borderColor: borderColor,
      prefixIcon: const Padding(
        padding: EdgeInsets.only(left: 16),
        child: Icon(
          Icons.lock_outline_rounded,
          color: colors.onSurface.resolve(context),
        ),
      ),
      maxLines: 1,
      hintText: hintText,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText.value,
      onChange: onChange,
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
