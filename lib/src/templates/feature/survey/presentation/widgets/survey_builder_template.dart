String surveyBuilderTemplate(String projectName) => '''
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/features/survey/survey_index.dart';

part 'overview_mode.dart';
part 'question_mode.dart';

class SurveyBuilder<T> extends StatefulWidget {
  const SurveyBuilder({
    required this.title,
    required this.builder,
    required this.surveys,
    super.key,
    this.showAnswers = false,
    this.selectedAnswers,
    this.surveyAnswers,
    this.onSubmitted,
    this.onQuestionAnswered,
    this.bottomBuilder,
    this.onOverviewTap,
  });
  final String title;
  final SurveyQuestion Function(T) builder;
  final List<T> surveys;
  final bool showAnswers;
  final List<SurveyAnswer>? surveyAnswers;
  final List<SurveyAnswer>? selectedAnswers;
  final ValueChanged<List<SurveyAnswer>>? onSubmitted;
  final ValueChanged<List<SurveyAnswer>>? onQuestionAnswered;
  final Widget Function(T)? bottomBuilder;
  final VoidCallback? onOverviewTap;

  @override
  State<SurveyBuilder<T>> createState() => _SurveyBuilderState<T>();
}

class _SurveyBuilderState<T> extends State<SurveyBuilder<T>> {
  late List<SurveyAnswer> answers;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    answers = widget.surveys.map((e) {
      final survey = widget.builder(e);
      final input = widget.selectedAnswers
          ?.where((e) => e.question == survey.id)
          .singleOrNull;
      return SurveyAnswer(
        question: widget.builder(e).id,
        answer: input?.answer,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final pageIndex = ValueNotifier(0);
    final mode = context.watch<SurveyModeCubit>().state;

    if (widget.surveys.isEmpty) {
      return const Center(child: Text('Nothing here yet'));
    }

    return ListenableBuilder(
      listenable: pageIndex,
      builder: (context, _) {
        return Column(
          children: [
            LinearProgressIndicator(
              value: (pageIndex.value + 1) / widget.surveys.length,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: switch (mode) {
                SurveyMode.overview => _OverviewMode(
                    answers: answers,
                    surveys: widget.surveys,
                    surveyAnswers: widget.surveyAnswers,
                    selectedAnswers: widget.selectedAnswers,
                    builder: widget.builder,
                    showAnswers: widget.showAnswers,
                    onBackPressed: () => _jumpTo(pageIndex.value),
                    onQuestionTap: (value) {
                      _jumpTo(pageIndex.value);
                      _jumpTo(value);
                    },
                  ),
                SurveyMode.question => _QuestionMode(
                    onPageChanged: (value) => pageIndex.value = value,
                    pageIndex: pageIndex.value,
                    answers: answers,
                    selectedAnswers: widget.selectedAnswers,
                    surveyAnswers: widget.surveyAnswers,
                    title: widget.title,
                    controller: pageController,
                    builder: widget.builder,
                    surveys: widget.surveys,
                    onSubmitted: widget.onSubmitted,
                    showAnswers: widget.showAnswers,
                    bottomBuilder: widget.bottomBuilder,
                    onChanged: (value) {
                      widget.onQuestionAnswered?.call(answers);
                      setState(() {});
                    },
                  ),
              },
            ),
          ],
        );
      },
    );
  }

  void _jumpTo(int page) {
    const duration = Duration(milliseconds: 50);
    context.read<SurveyModeCubit>().reset();
    Timer(duration, () => pageController.jumpToPage(page));
  }
}
''';
