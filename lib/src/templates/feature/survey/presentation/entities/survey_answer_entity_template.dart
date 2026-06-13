String surveyAnswerEntityTemplate(String projectName) => '''
class SurveyAnswer {
  SurveyAnswer({
    required this.question,
    this.answer,
  });

  String question;
  dynamic answer;

  factory SurveyAnswer.fromJson(Map<String, dynamic> json) {
    return SurveyAnswer(
      question: json['question_id'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['question_id'] = question;
    if (answer != null) data['answer'] = answer;
    return data;
  }
}
''';
