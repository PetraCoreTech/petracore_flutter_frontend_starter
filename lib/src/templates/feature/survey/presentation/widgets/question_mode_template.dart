String questionModeTemplate(String projectName) => '''
part of 'survey_builder.dart';

class _QuestionMode<T> extends StatelessWidget {
  const _QuestionMode({
    required this.controller,
    required this.title,
    required this.builder,
    required this.surveys,
    required this.answers,
    required this.pageIndex,
    required this.showAnswers,
    super.key,
    this.onSubmitted,
    this.bottomBuilder,
    this.onChanged,
    this.selectedAnswers,
    this.surveyAnswers,
    this.onPageChanged,
  });
  final PageController controller;
  final String title;
  final SurveyQuestion Function(T) builder;
  final List<T> surveys;
  final List<SurveyAnswer>? surveyAnswers;
  final List<SurveyAnswer>? selectedAnswers;
  final ValueChanged<List<SurveyAnswer>>? onSubmitted;
  final Widget Function(T)? bottomBuilder;
  final List<SurveyAnswer> answers;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<int>? onPageChanged;
  final int pageIndex;
  final bool showAnswers;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: onPageChanged,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: surveys.length,
      itemBuilder: (context, index) {
        final item = surveys[index];
        final survey = builder.call(item);
        final selectedAnswer = answers[index];
        final surveyAnswer =
            surveyAnswers?.where((e) => e.question == survey.id).singleOrNull;
        final surveyAnswerDisplay = selectedAnswers
            ?.where((e) => e.question == survey.id)
            .singleOrNull;

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'QUESTION \${pageIndex + 1} OF \${surveys.length}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(height: 8),
                    if (showAnswers)
                      SurveyAnswerDisplay(
                        survey: survey,
                        answer: surveyAnswer?.answer,
                        selectedAnswer: surveyAnswerDisplay?.answer,
                        bottom: bottomBuilder?.call(item),
                      )
                    else
                      SurveyQuestionDisplay(
                        survey: survey,
                        answer: selectedAnswer.answer,
                        onChanged: (value) {
                          selectedAnswer.answer = value;
                          onChanged?.call(value);
                        },
                        onSubmitted: onChanged,
                        bottom: bottomBuilder?.call(item),
                      ),
                  ],
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
                      Row(
                        children: [
                          if (pageIndex != 0)
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => controller.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                ),
                                child: const Text('Prev'),
                              ),
                            ),
                          if (pageIndex != 0 &&
                              pageIndex != surveys.length - 1)
                            const SizedBox(width: 16),
                          if (pageIndex != surveys.length - 1)
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => controller.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                ),
                                child: const Text('Next'),
                              ),
                            ),
                        ],
                      ),
                      if (!showAnswers) ...[
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => onSubmitted?.call(answers),
                            child: Text('Submit \$title'),
                          ),
                        ),
                      ],
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
''';
