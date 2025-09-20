import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String baseTextFieldTemplate(ProjectConfig config) => '''
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
    final colors = \$token.color;
    final bColor = borderColor ?? colors.border.resolve(context);
    final focusedBorderColor =
        borderColor ?? colors.focusedBorder.resolve(context);
    final errorBorderColor = borderColor ?? colors.errorBorder.resolve(context);
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
      cursorColor: colors.onSurfaceDark.resolve(context),
      style: style ??
          \$token.textStyle.label3.resolve(context).copyWith(
                color: colors.inputText.resolve(context),
              ),
      decoration: InputDecoration(
        filled: filled,
        fillColor: fillColor,
        hintText: hintText,
        constraints: constraints,
        alignLabelWithHint: alignLabelWithHint,
        label: labelText != null
            ? Text(
                labelText!,
                style: labelStyle ??
                    \$token.textStyle.label3.resolve(context).copyWith(
                          color: colors.inputLabel.resolve(context),
                        ),
              )
            : const SizedBox.shrink(),
        errorStyle: \$token.textStyle.label4.resolve(context).copyWith(
              color: colors.error.resolve(context),
            ),
        disabledBorder: _border(bColor, radius: radius),
        enabledBorder: _border(bColor, radius: radius),
        focusedErrorBorder: _border(focusedBorderColor, radius: radius),
        errorBorder: _border(errorBorderColor, radius: radius),
        focusedBorder: _border(focusedBorderColor, radius: radius),
        border: _border(bColor, radius: radius),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }

  InputBorder _border(Color color, {double? radius}) {
    if (border != null) {
      return border!.copyWith(
        borderSide: BorderSide(color: color),
      );
    }
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 8),
      borderSide: BorderSide(color: color),
    );
  }
}
''';
