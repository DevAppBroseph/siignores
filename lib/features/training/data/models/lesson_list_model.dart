import 'package:siignores/features/training/domain/entities/lesson_list_entity.dart';

class LessonListModel extends LessonListEntity{
  LessonListModel({
    required int id,
    required int moduleId,
    required String title,
    required String text,
    required String? image,
    required String? status,
    required String miniDesc

  }) : super(
    id: id, 
    title: title,
    image: image,
    moduleId: moduleId,
    text: text,
    status: status,
    miniDesc: miniDesc
  );

  factory LessonListModel.fromJson(Map<String, dynamic> json) => LessonListModel(
    id: json['id'] ?? 1,
    title: json['name'],
    image: json['image'],
    moduleId: json['module'],
    text: json['text'],
    status: json['status'],
    miniDesc: json['short_desc'] ?? ''
    
  );
}