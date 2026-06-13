String surveyQuestionDisplayTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:$projectName/features/survey/survey_index.dart';

class SurveyQuestionDisplay extends StatelessWidget {
  const SurveyQuestionDisplay({
    required this.survey,
    super.key,
    this.answer,
    this.onChanged,
    this.onSubmitted,
    this.bottom,
  });

  final SurveyQuestion survey;
  final dynamic answer;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSubmitted;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          survey.text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        if (survey.options != null && survey.options!.isNotEmpty)
          ...survey.options!.map(
            (option) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SurveyOptionSelector<String>(
                title: Text(option),
                value: option,
                groupValue: answer as String?,
                onChanged: onChanged,
              ),
            ),
          ),
        if (survey.options == null || survey.options!.isEmpty)
          TextField(
            onChanged: onChanged,
            decoration: const InputDecoration(
              hintText: 'Enter your answer...',
            ),
          ),
        if (bottom != null) ...[const SizedBox(height: 16), bottom!],
      ],
    );
  }
}
''';
