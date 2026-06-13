String surveyAnswerDisplayTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:$projectName/features/survey/survey_index.dart';

class SurveyAnswerDisplay extends StatelessWidget {
  const SurveyAnswerDisplay({
    required this.survey,
    super.key,
    this.answer,
    this.selectedAnswer,
    this.bottom,
  });

  final SurveyQuestion survey;
  final dynamic answer;
  final dynamic selectedAnswer;
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
        const SizedBox(height: 8),
        if (answer != null)
          _resultRow(context, 'Correct answer', answer, Colors.green),
        if (selectedAnswer != null)
          _resultRow(
            context,
            'Your answer',
            selectedAnswer,
            answer == selectedAnswer ? Colors.green : Colors.red,
          ),
        if (bottom != null) ...[const SizedBox(height: 16), bottom!],
      ],
    );
  }

  Widget _resultRow(BuildContext context, String label, dynamic value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            '\$label: \$value',
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
''';
