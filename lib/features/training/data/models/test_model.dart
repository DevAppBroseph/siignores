import '../../domain/entities/test_entity.dart';

class TestModel extends TestEntity {
  TestModel({
    required int id,
    required String title,
    required String? description,
    required List<QuestionTest> questions,
    required bool? isExam,
    required bool isChecked,
  }) : super(
            id: id,
            title: title,
            description: description,
            questions: questions,
            isChecked: isChecked,
            isExam: isExam);

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
        id: json['id'] ?? 1,
        title: json['name'],
        description: json['description'],
        isExam: json['is_exam'],
        isChecked: json['is_blocked'] ?? false,
        questions: json['question_set'] == null
            ? []
            : (json['question_set'] as List)
                .map((json) => QuestionTest.fromJson(json))
                .toList(),
      );
}

class QuestionTest {
  final int id;
  final String title;
  final List<OptionTest> options;
  final bool unanswered;

  QuestionTest(
      {required this.id,
      required this.title,
      required this.options,
      required this.unanswered});

  factory QuestionTest.fromJson(Map<String, dynamic> json) => QuestionTest(
      id: json['id'] ?? 1,
      title: json['name'],
      unanswered: json['unanswered'],
      options: json['option_set'] == null
          ? []
          : (json['option_set'] as List)
              .map((json) => OptionTest.fromJson(json))
              .toList());
}

class OptionTest {
  final int id;
  final String text;
  final bool isCorrect;

  OptionTest({required this.id, required this.text, required this.isCorrect});

  factory OptionTest.fromJson(Map<String, dynamic> json) => OptionTest(
      id: json['id'] ?? 1, text: json['text'], isCorrect: json['is_correct']);
}
