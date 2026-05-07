import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialPhoneFieldTemplate(ProjectConfig config) => '''
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:${config.projectName}/app/app.dart';
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
    final theme = Theme.of(context);
    final bColor = borderColor ?? theme.colorScheme.outline;
    final focusedBorderColor = borderColor ?? theme.colorScheme.primary;
    final errorBorderColor = borderColor ?? theme.colorScheme.error;
    final surface = theme.colorScheme.surface;

    final dialogStyle = theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
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
      cursorColor: theme.colorScheme.onSurface,
      validator: (value) => validator?.call(value?.number, country.value),
      style: style ?? theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      dropdownTextStyle: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
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
        labelStyle: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
        contentPadding: contentPadding ?? const EdgeInsets.all(16),
        errorStyle: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.error,
              fontSize: 12,
            ),
        disabledBorder: _border(bColor, radius: radius, theme: theme),
        enabledBorder: _border(bColor, radius: radius, theme: theme),
        focusedErrorBorder: _border(focusedBorderColor, radius: radius, theme: theme),
        errorBorder: _border(errorBorderColor, radius: radius, theme: theme),
        focusedBorder: _border(focusedBorderColor, radius: radius, theme: theme),
        border: _border(bColor, radius: radius, theme: theme),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        constraints: constraints,
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

extension PhoneNumberStringExt on String {
  String number() {
    final value = PhoneNumber.fromCompleteNumber(completeNumber: this);
    return value.number;
  }

  String countryISOCode() {
    final value = PhoneNumber.fromCompleteNumber(completeNumber: this);
    return value.countryISOCode;
  }
}
''';
