import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialBottomSheetSelectContentTemplate(ProjectConfig config) => '''
// ignore_for_file: avoid_positional_boolean_parameters

import 'package:${config.projectName}/core/core.dart';

class BottomSheetSelectContent<T> extends HookWidget {
  const BottomSheetSelectContent({
    required this.items,
    super.key,
    this.search = false,
    this.maxHeight,
    this.showSuffix,
    this.extraItem,
    this.itemPadding,
    this.titleStyle,
    this.groupValue,
    this.scrollPadding,
    this.onChanged,
    this.itemPrefix,
  });

  final bool search;
  final double? maxHeight;
  final bool? showSuffix;
  final Widget? extraItem;
  final EdgeInsets? itemPadding;
  final TextStyle? titleStyle;
  final List<InputItem<T>> items;
  final T? groupValue;
  final EdgeInsetsGeometry? scrollPadding;
  final void Function(T? value)? onChanged;
  final Widget Function(bool isSelected, T? value)? itemPrefix;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryDark = theme.colorScheme.primary;
    final label3 = theme.textTheme.bodySmall;
    final highlightedValue = ValueNotifier<T?>(groupValue);
    final searchItems = useState<List<InputItem<T>>>(items);
    final filtered = useState<List<InputItem<T>>>(items);
    final itemsList = SingleChildScrollView(
      padding: scrollPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...filtered.value.map(
            (e) => SelectItemV2<T>(
              title: e.title,
              titleStyle: titleStyle ??
                  label3?.copyWith(color: theme.colorScheme.onSurface),
              subtitle: e.subtitle,
              prefix: itemPrefix,
              showSuffix: showSuffix,
              showHighlighted: false,
              padding: itemPadding,
              highlightedValue: highlightedValue,
              suffixIcon: Icon(Icons.check, color: primaryDark),
              value: e.value,
              onHover: (value) {
                highlightedValue.value = e.value;
              },
              onTap: () {
                Navigator.of(context).pop();
                onChanged?.call(e.value);
              },
            ),
          ),
          if (extraItem != null) extraItem!,
        ],
      ),
    );
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: (maxHeight ?? 700) - bottom),
      child: search
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SearchFeatureField(
                    labelText: 'Search',
                    onChanged: (value) {
                      final input =
                          [...searchItems.value].filteredByTitle(value);
                      filtered.value = input;
                    },
                    onFieldSubmitted: (value) {
                      final input =
                          [...searchItems.value].filteredByTitle(value);
                      filtered.value = input;
                    },
                  ),
                ),
                const Gap(8),
                Flexible(child: itemsList),
              ],
            )
          : itemsList,
    );
  }
}

class SelectItemV2<T> extends StatelessWidget {
  const SelectItemV2({
    required this.highlightedValue,
    this.title,
    super.key,
    this.titleStyle,
    this.child,
    this.subtitle,
    this.value,
    this.onTap,
    this.onHover,
    this.padding,
    this.prefix,
    this.suffix,
    this.prefixIconData,
    this.prefixIconColor,
    this.prefixIconSize,
    this.showSuffix,
    this.suffixIcon,
    this.showHighlighted = true,
  });

  final bool showHighlighted;
  final bool? showSuffix;
  final String? title;
  final String? subtitle;
  final Widget? child;
  final Widget? suffix;
  final Widget? suffixIcon;
  final TextStyle? titleStyle;
  final VoidCallback? onTap;
  final IconData? prefixIconData;
  final Color? prefixIconColor;
  final double? prefixIconSize;
  final EdgeInsets? padding;
  final T? value;
  final void Function(bool? value)? onHover;
  final ValueNotifier<T?> highlightedValue;
  final Widget Function(bool isSelected, T? value)? prefix;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder(
      valueListenable: highlightedValue,
      builder: (context, highlight, _) {
        final isSelected = value == highlight;
        final item = Padding(
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: child ??
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (prefix != null)
                    prefix!.call(isSelected, value)
                  else if (prefixIconData != null)
                    Icon(
                      prefixIconData,
                      size: prefixIconSize ?? 20,
                      color: prefixIconColor ??
                          theme.colorScheme.onSurfaceVariant,
                    ),
                  if (prefix != null || prefixIconData != null) const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title!,
                          style: titleStyle ??
                              theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                        ),
                        if (subtitle != null) ...[
                          Text(
                            subtitle!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Gap(12),
                  if (isSelected && (showSuffix ?? true))
                    suffixIcon ??
                        Icon(
                          Icons.check,
                          color: theme.colorScheme.primary,
                        )
                  else if (suffix != null)
                    suffix!,
                ],
              ),
        );
        return InkWell(
          onHover: onHover,
          onTap: onTap,
          child: showHighlighted
              ? DecoratedBox(
                  decoration: BoxDecoration(
                    color: isSelected ? theme.colorScheme.surfaceContainerHighest : null,
                  ),
                  child: item,
                )
              : item,
        );
      },
    );
  }
}

extension SearchInputExt<T> on List<InputItem<T>> {
  List<InputItem<T>> filteredByTitle(String query) {
    return where((e) => e.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
''';
