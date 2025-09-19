import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String phoneFieldTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:${config.projectName}/core/core.dart';

class PhoneField extends HookWidget {
  const PhoneField({
    super.key,
    this.readOnly,
    this.radius,
    this.label,
    this.hint,
    this.border,
    this.borderColor,
    this.initialValue,
    this.initialCountryCode,
    this.style,
    this.enabled,
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.filled,
    this.fillColor,
    this.validator,
    this.contentPadding,
    this.textInputAction,
    this.constraints,
  });

  final double? radius;
  final String? label;
  final String? hint;
  final String? initialValue;
  final String? initialCountryCode;
  final bool? enabled;
  final bool? readOnly;
  final bool? filled;
  final Color? fillColor;
  final Color? borderColor;
  final TextStyle? style;
  final InputBorder? border;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String? value, Country? country)? validator;
  final void Function(PhoneNumber)? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    final colors = \$token.color;
    final bColor = borderColor ?? colors.border.resolve(context);
    final focusedBorderColor =
        borderColor ?? colors.focusedBorder.resolve(context);
    final errorBorderColor = borderColor ?? colors.errorBorder.resolve(context);
    final surface = colors.surface.resolve(context);
    final dialogStyle = \$token.textStyle.paragraph3.resolve(context).copyWith(
          color: colors.onSurfaceDark.resolve(context),
        );

    final country = useState<Country?>(
      countries
          .where((element) => element.code == (initialCountryCode ?? 'NG'))
          .first,
    );
    return IntlPhoneField(
      controller: controller,
      initialCountryCode: initialCountryCode ?? 'NG',
      cursorHeight: 18,
      textInputAction: textInputAction ?? TextInputAction.done,
      enabled: enabled ?? true,
      readOnly: readOnly ?? false,
      disableLengthCheck: true,
      showDropdownIcon: false,
      flagsButtonPadding: const EdgeInsets.only(left: 16),
      cursorColor: colors.inputText.resolve(context),
      validator: (value) => validator?.call(value?.number, country.value),
      style: style ??
          \$token.textStyle.label3.resolve(context).copyWith(
                color: colors.onSurfaceDark.resolve(context),
              ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      dropdownTextStyle: \$token.textStyle.paragraph3.resolve(context).copyWith(
            color: colors.onSurfaceDark.resolve(context),
          ),
      pickerDialogStyle: PickerDialogStyle(
        countryCodeStyle: dialogStyle,
        countryNameStyle: dialogStyle,
        backgroundColor: surface,
      ),
      onChanged: (value) => onChanged?.call(value),
      onSubmitted: onFieldSubmitted,
      onCountryChanged: (value) => country.value = value,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: filled,
        fillColor: fillColor,
        labelStyle: \$token.textStyle.label3.resolve(context).copyWith(
              color: colors.inputLabel.resolve(context),
            ),
        contentPadding: contentPadding ?? const EdgeInsets.all(16),
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
        constraints: constraints,
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

///
extension PhoneNumberStringExt on String {
  ///
  String number() {
    final value = PhoneNumber.fromCompleteNumber(completeNumber: this);
    return value.number;
  }

  ///
  String countryISOCode() {
    final value = PhoneNumber.fromCompleteNumber(completeNumber: this);
    return value.countryISOCode;
  }
}
''';
