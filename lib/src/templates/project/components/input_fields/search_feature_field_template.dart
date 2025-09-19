import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String searchFeatureFieldTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/app/app.dart';

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
    const transparent = Colors.transparent;
    final onSurfaceDark = colors.onSurfaceDark.resolve(context);
    final onSurfaceLight = colors.onSurfaceLight.resolve(context);
    final paragraph3 = \$token.textStyle.paragraph3.resolve(context);
    return TextFormField(
      style: paragraph3.copyWith(color: onSurfaceDark),
      controller: controller,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.webSearch,
      cursorColor: onSurfaceDark,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle ?? paragraph3.copyWith(color: onSurfaceLight),
        filled: true,
        fillColor: colors.hover.resolve(context),
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
