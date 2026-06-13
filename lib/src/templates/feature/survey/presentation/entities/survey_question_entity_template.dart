String surveyQuestionEntityTemplate(String projectName) => '''
class SurveyQuestion {
  SurveyQuestion({
    required this.text,
    this.id = '',
    this.options,
  });
  final String id;
  final String text;
  final List<String>? options;
}
''';
