import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String searchInputFieldTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/app/app.dart';

class SearchInputField<T> extends HookWidget {
  const SearchInputField({
    required this.items,
    required this.value,
    super.key,
    this.label,
    this.placeHolder,
    this.labelStyle,
    this.style,
    this.suffixIcon,
    this.onChanged,
    this.search = false,
    this.required = false,
  });
  final String? label;
  final String? placeHolder;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final Widget? suffixIcon;
  final List<InputItem<T>> items;
  final ValueNotifier<T?> value;
  final ValueChanged<T>? onChanged;
  final bool search;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final inputLabel = colors.inputText.resolve(context);
    return ValueListenableBuilder(
        valueListenable: value,
        builder: (context, value, _) {
          final InputItem<T>? item;
          if (items.isNotEmpty && value != null) {
            item = items.where((e) => e.value == value).singleOrNull;
          } else {
            item = null;
          }
          final controller = TextEditingController(text: item?.title);
          return FormField(
            builder: (state) => BaseTextField(
              readOnly: true,
              label: label,
              placeHolder: placeHolder,
              labelStyle: labelStyle,
              style: style,
              validator: required
                  ? (_) => InputFieldValidator.requiredReadOnly(controller)
                  : null,
              suffixIcon: suffixIcon ??
                  Icon(Icons.keyboard_arrow_down, color: inputLabel),
              controller: controller,
              onTap: () {
                _showSelectDialog(
                  context,
                  onChanged: (value) {
                    onChanged?.call(value);
                    state.didChange(value);
                  },
                );
              },
            ),
          );
        });
  }

  /// Update form field state [FormFieldFrame.onTap];
  /// check properties above for details
  Future<Widget?> _showSelectDialog(
    BuildContext context, {
    ValueChanged<T>? onChanged,
  }) {
    return DialogHelper(context).showBottomSheet(
      child: BottomSheetSelectContent(
        items: items,
        search: search,
        groupValue: value.value,
        itemPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        onChanged: (value) {
          if (value != null) {
            onChanged?.call(value);
          }
        },
      ),
    );
  }
}
''';
