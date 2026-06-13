String surveyOptionSelectorTemplate(String projectName) => '''
import 'package:flutter/material.dart';

class SurveyOptionSelector<T> extends StatelessWidget {
  const SurveyOptionSelector({
    required this.title,
    super.key,
    this.leading,
    this.value,
    this.groupValue,
    this.onChanged,
  });
  final Widget? leading;
  final Widget title;
  final T? value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: isSelected
            ? Theme.of(context).primaryColor
            : Theme.of(context).cardColor,
        border: Border.all(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).dividerColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 8)],
            Expanded(child: title),
            const SizedBox(width: 8),
            if (isSelected)
              Icon(
                Icons.radio_button_checked,
                color: Theme.of(context).cardColor,
              )
            else
              const Icon(Icons.radio_button_unchecked),
          ],
        ),
      ),
    );
  }
}
''';
