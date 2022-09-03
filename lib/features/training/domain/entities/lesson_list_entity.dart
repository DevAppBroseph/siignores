import 'package:equatable/equatable.dart';

class LessonListEntity extends Equatable {
  final int id;
  final int moduleId;
  final String title;
  final String text;
  final String? image;
  final String? question;
  final String miniDesc;
  String? status;
  bool isOpen;

  LessonListEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.moduleId,
    required this.question,
    required this.text,
    required this.status,
    required this.miniDesc,
    this.isOpen = false
  });



  @override
  List<Object> get props => [
        id,
        title,
        moduleId,
        text
      ];
}
