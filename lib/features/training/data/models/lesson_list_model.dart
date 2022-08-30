import 'package:siignores/features/training/domain/entities/lesson_list_entity.dart';

class LessonListModel extends LessonListEntity{
  LessonListModel({
    required int id,
    required int moduleId,
    required String title,
    required String text,
    required String? image,

  }) : super(
    id: id, 
    title: title,
    image: image,
    moduleId: moduleId,
    text: text
  );

  factory LessonListModel.fromJson(Map<String, dynamic> json) => LessonListModel(
    id: json['id'] ?? 1,
    title: json['name'],
    image: json['image'],
    moduleId: json['module'],
    text: json['text']
    
  );
}