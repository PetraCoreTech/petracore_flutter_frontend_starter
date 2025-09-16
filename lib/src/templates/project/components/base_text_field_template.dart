import '../../../generators/project_generator.dart';

String baseTextFieldTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '../../theme/design_tokens/theme_token.dart';

/// Validator callback type
typedef ValidatorCallback = String? Function(String?);

/// Base text field component with mixtheme integration for ${config.projectName}
class BaseTextField extends StatelessWidget {
  /// Constructor
  const BaseTextField({
    super.key,
    this.label,
    this.hintText,
    this.initialValue,
    this.style,
    this.labelStyle,
    this.floatingLabelStyle,
    this.onTap,
    this.hasFocus = true,
    this.obscureText = false,
    this.autofocus = false,
    this.alignLabelWithHint,
    this.filled,
    this.fillColor,
    this.enabled,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.onChange,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.minLines,
    this.maxLines,
    this.readOnly,
    this.maxLength,
    this.maxLengthEnforcement,
    this.contentPadding,
    this.textInputAction,
    this.constraints,
    this.textCapitalization = TextCapitalization.none,
    this.placeHolder,
  });

  final String? label;
  final String? hintText;
  final String? initialValue;
  final bool obscureText;
  final bool autofocus;
  final bool? filled;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final bool? enabled;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final ValidatorCallback? validator;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final bool? readOnly;
  final bool? alignLabelWithHint;
  final VoidCallback? onEditingComplete;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final EdgeInsetsGeometry? contentPadding;
  final bool hasFocus;
  final BoxConstraints? constraints;
  final String? placeHolder;

  @override
  Widget build(BuildContext context) {
    final colors = \$token.color;
    final label2Style = \$token.textStyle.label2.resolve(context);
    final inputLabelColor = colors.inputLabel.resolve(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: labelStyle ?? label2Style.copyWith(color: inputLabelColor),
          ),
          const Gap(4),
        ],
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          style: style,
          obscureText: obscureText,
          autofocus: autofocus,
          enabled: enabled,
          readOnly: readOnly ?? false,
          onTap: onTap,
          onChanged: onChange,
          onFieldSubmitted: onFieldSubmitted,
          onEditingComplete: onEditingComplete,
          validator: validator,
          textCapitalization: textCapitalization,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          minLines: minLines,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          maxLengthEnforcement: maxLengthEnforcement,
          decoration: InputDecoration(
            hintText: hintText ?? placeHolder,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: filled,
            fillColor: fillColor ?? colors.fill.resolve(context),
            contentPadding: contentPadding ?? const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colors.border.resolve(context),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colors.border.resolve(context),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colors.focusedBorder.resolve(context),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colors.errorBorder.resolve(context),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colors.errorBorder.resolve(context),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
''';
