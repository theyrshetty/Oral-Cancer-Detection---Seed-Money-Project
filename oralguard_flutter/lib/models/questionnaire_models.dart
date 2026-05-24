// Models for OralGuard questionnaire

enum AnswerValue { yes, no, unanswered }

class DiffQuestion {
  final String id;
  final String text;
  final String? hint;
  AnswerValue answer;

  DiffQuestion({
    required this.id,
    required this.text,
    this.hint,
    this.answer = AnswerValue.unanswered,
  });
}

class QuestionItem {
  final String id;
  final String text;
  final String? hint;
  final List<DiffQuestion> diffQuestions; // follow-up questions if "yes"
  AnswerValue answer;

  QuestionItem({
    required this.id,
    required this.text,
    this.hint,
    this.diffQuestions = const [],
    this.answer = AnswerValue.unanswered,
  });

  bool get hasDiff => diffQuestions.isNotEmpty;
  bool get showDiff => answer == AnswerValue.yes && hasDiff;
}

class QuestionSection {
  final String title;
  final String subtitle;
  final String icon;
  final List<QuestionItem> questions;

  const QuestionSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.questions,
  });
}

// Risk assessment result
enum RiskLevel { high, caution, consult, diffDiagnosis, none }

class RiskResult {
  final RiskLevel level;
  final String title;
  final String body;
  final String? diffNote;
  final List<String> bullets;

  const RiskResult({
    required this.level,
    required this.title,
    required this.body,
    this.diffNote,
    required this.bullets,
  });
}
