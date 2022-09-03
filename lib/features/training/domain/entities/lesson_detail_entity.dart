import 'package:equatable/equatable.dart';
import 'package:siignores/features/training/data/models/lesson_detail_model.dart';

class LessonDetailEntity extends Equatable {
  final int id;
  final int moduleId;
  final int lessonNumber;
  final String title;
  final String text;
  final String question;
  final String? image;
  final String? backImage;
  final String? video;
  final List<TimeOfVideo> times;
  final List<LessonFile> files;

  LessonDetailEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.moduleId,
    required this.lessonNumber,
    required this.text,
    required this.video,
    required this.question,
    required this.times,
    required this.files,
    required this.backImage,
  });

  @override
  List<Object> get props => [id, title, moduleId, text, question];
}
