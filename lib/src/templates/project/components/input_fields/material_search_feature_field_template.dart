import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialSearchFeatureFieldTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:${config.projectName}/core/core.dart';

class SearchFeatureField extends StatelessWidget {
  const SearchFeatureField({
    super.key,
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.labelText,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
  });
  final String? labelText;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const transparent = Colors.transparent;
    return TextFormField(
      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface),
      controller: controller,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.webSearch,
      cursorColor: theme.colorScheme.onSurface,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle ?? theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest,
        border: _border(transparent),
        focusedBorder: _border(transparent),
        errorBorder: _border(transparent),
        focusedErrorBorder: _border(transparent),
        enabledBorder: _border(transparent),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  InputBorder _border(Color color, {double? radius}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 8),
      borderSide: BorderSide(color: color),
    );
  }
}
''';
