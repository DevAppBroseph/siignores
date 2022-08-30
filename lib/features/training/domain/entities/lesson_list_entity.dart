import 'package:equatable/equatable.dart';

class LessonListEntity extends Equatable {
  final int id;
  final int moduleId;
  final String title;
  final String text;
  final String? image;

  LessonListEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.moduleId,
    required this.text,
  });



  @override
  List<Object> get props => [
        id,
        title,
        moduleId,
        text
      ];
}
