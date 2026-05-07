import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialBaseTextFieldTemplate(ProjectConfig config) => '''
import 'package:flutter/services.dart';
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/core/core.dart';

typedef ValidatorCallback = String? Function(String?);

class BaseTextField extends StatelessWidget {
  const BaseTextField({
    this.radius,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.style,
    this.labelStyle,
    this.obscureText = false,
    this.autofocus = false,
    this.enabled,
    this.filled,
    this.alignLabelWithHint,
    this.fillColor,
    this.keyboardType,
    this.suffixIcon,
    this.controller,
    super.key,
    this.validator,
    this.onChange,
    this.onFieldSubmitted,
    this.onSaved,
    this.inputFormatters,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.prefixIcon,
    this.constraints,
    this.focusNode,
    this.border,
    this.borderColor,
    this.onTap,
    this.readOnly,
    this.contentPadding,
    this.maxLengthEnforcement,
  });

  final double? radius;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final bool obscureText;
  final bool autofocus;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final bool? enabled;
  final bool? readOnly;
  final bool? filled;
  final bool? alignLabelWithHint;
  final Color? fillColor;
  final Color? borderColor;
  final BoxConstraints? constraints;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final ValidatorCallback? validator;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String?>? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? border;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;
    final bColor = borderColor ?? theme.colorScheme.outline;
    final focusedBorderColor = borderColor ?? theme.colorScheme.primary;
    final errorBorderColor = borderColor ?? theme.colorScheme.error;
    return TextFormField(
      onTap: onTap,
      textInputAction: textInputAction,
      obscuringCharacter: '*',
      scrollPadding: EdgeInsets.zero,
      readOnly: readOnly ?? false,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChange,
      validator: validator,
      autofocus: autofocus,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      obscureText: obscureText,
      initialValue: initialValue,
      keyboardType: keyboardType ?? TextInputType.name,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      enabled: enabled,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      buildCounter: (
        context, {
        required currentLength,
        required isFocused,
        required maxLength,
      }) =>
          const SizedBox.shrink(),
      cursorHeight: 18,
      cursorColor: theme.colorScheme.onSurfaceVariant,
      style: style ?? theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        filled: filled,
        fillColor: fillColor,
        hintText: hintText,
        constraints: constraints,
        alignLabelWithHint: alignLabelWithHint,
        label: labelText != null
            ? Text(
                labelText!,
                style: labelStyle ?? inputTheme.labelStyle,
              )
            : const SizedBox.shrink(),
        errorStyle: inputTheme.errorStyle,
        disabledBorder: _border(bColor, radius: radius, theme: theme),
        enabledBorder: _border(bColor, radius: radius, theme: theme),
        focusedErrorBorder: _border(focusedBorderColor, radius: radius, theme: theme),
        errorBorder: _border(errorBorderColor, radius: radius, theme: theme),
        focusedBorder: _border(focusedBorderColor, radius: radius, theme: theme),
        border: _border(bColor, radius: radius, theme: theme),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: contentPadding ?? inputTheme.contentPadding,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }

  InputBorder _border(Color color, {double? radius, required ThemeData theme}) {
    final rad = radius ?? (theme.inputDecorationTheme.border as OutlineInputBorder?)?.borderRadius.topLeft.x ?? 8;
    if (border != null) {
      return border!.copyWith(
        borderSide: BorderSide(color: color),
      );
    }
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(rad),
      borderSide: BorderSide(color: color),
    );
  }
}
''';
