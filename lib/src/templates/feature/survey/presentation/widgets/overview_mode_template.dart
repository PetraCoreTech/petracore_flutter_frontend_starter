String overviewModeTemplate(String projectName) => '''
part of 'survey_builder.dart';

class _OverviewMode<T> extends StatelessWidget {
  const _OverviewMode({
    required this.answers,
    required this.surveys,
    required this.builder,
    required this.showAnswers,
    super.key,
    this.selectedAnswers,
    this.surveyAnswers,
    this.onBackPressed,
    this.onQuestionTap,
  });
  final List<SurveyAnswer> answers;
  final List<T> surveys;
  final List<SurveyAnswer>? surveyAnswers;
  final List<SurveyAnswer>? selectedAnswers;
  final VoidCallback? onBackPressed;
  final SurveyQuestion Function(T) builder;
  final ValueChanged<int>? onQuestionTap;
  final bool showAnswers;

  @override
  Widget build(BuildContext context) {
    final answeredQuestions = answers.where((e) => e.answer != null).toList();
    final submittedAnswers =
        selectedAnswers?.where((e) => e.answer != null).toList();
    final answerCount = showAnswers
        ? (submittedAnswers?.length ?? 0)
        : answeredQuestions.length;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'QUESTION OVERVIEW (\$answerCount/\${surveys.length})',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Quickly move between different questions.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: surveys.map((e) {
                final index = surveys.indexOf(e);
                final isAnswered = answers[index].answer != null;
                return GestureDetector(
                  onTap: () => onQuestionTap?.call(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: isAnswered
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).hoverColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '\${index + 1}',
                      style: TextStyle(
                        color: isAnswered
                            ? Theme.of(context).cardColor
                            : Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 48)),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: onBackPressed,
                      child: const Text('Back'),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
''';
