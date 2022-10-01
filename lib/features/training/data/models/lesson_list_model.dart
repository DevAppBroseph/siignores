import 'package:siignores/features/training/domain/entities/lesson_list_entity.dart';

class LessonListModel extends LessonListEntity {
  LessonListModel(
      {required int id,
      required int moduleId,
      required String title,
      required String text,
      required String? image,
      required String? question,
      required String? status,
      required String miniDesc,
      required bool isFinished,
      required List<int> tests})
      : super(
            id: id,
            title: title,
            image: image,
            moduleId: moduleId,
            question: question,
            text: text,
            status: status,
            isFinished: isFinished,
            miniDesc: miniDesc,
            tests: tests);

  factory LessonListModel.fromJson(Map<String, dynamic> json) =>
      LessonListModel(
          id: json['id'] ?? 1,
          title: json['name'],
          image: json['image'],
          question: json['question'],
          moduleId: json['module'],
          text: json['text'],
          status: json['status'],
          isFinished: json["is_finished"],
          tests: json['test_set'] == null
              ? []
              : (json['test_set'] as List)
                  .map((json) => int.parse(json.toString()))
                  .toList(),
          miniDesc: json['short_desc'] ?? '');
}
