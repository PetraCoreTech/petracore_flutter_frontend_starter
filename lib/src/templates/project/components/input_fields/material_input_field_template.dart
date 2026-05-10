import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialInputFieldTemplate(ProjectConfig config) => '''
import 'package:flutter/services.dart';
import 'package:${config.projectName}/core/core.dart';

class InputField extends StatelessWidget {
  const InputField({
    this.label,
    this.hint,
    this.initialValue,
    this.style,
    this.onTap,
    this.obscureText = false,
    this.filled,
    this.fillColor,
    this.enabled,
    this.keyboardType,
    this.suffixIcon,
    this.controller,
    super.key,
    this.onChange,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.minLines,
    this.maxLines,
    this.alignLabelWithHint,
    this.readOnly,
    this.validator,
    this.maxLength,
    this.maxLengthEnforcement,
    this.textCapitalization = TextCapitalization.none,
    this.placeHolder,
    this.labelStyle,
    this.placeHolderStyle,
  });

  final String? label;
  final String? placeHolder;
  final String? hint;
  final String? initialValue;
  final bool obscureText;
  final bool? filled;
  final Color? fillColor;
  final Widget? suffixIcon;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? placeHolderStyle;
  final bool? enabled;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final bool? readOnly;
  final bool? alignLabelWithHint;
  final VoidCallback? onEditingComplete;
  final ValidatorCallback? validator;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? '',
          style: labelStyle ??
              theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 4),
        BaseTextField(
          hintText: hint,
          alignLabelWithHint: alignLabelWithHint,
          initialValue: initialValue,
          obscureText: obscureText,
          filled: filled,
          fillColor: fillColor,
          suffixIcon: suffixIcon,
          style: style,
          labelText: placeHolder,
          labelStyle: placeHolderStyle,
          enabled: enabled,
          textCapitalization: textCapitalization,
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          onChange: onChange,
          onFieldSubmitted: onFieldSubmitted,
          onTap: onTap,
          readOnly: readOnly,
          minLines: minLines,
          maxLines: maxLines,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          maxLengthEnforcement: maxLengthEnforcement,
        ),
      ],
    );
  }
}
''';
