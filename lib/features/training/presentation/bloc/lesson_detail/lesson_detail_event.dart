part of 'lesson_detail_bloc.dart';

class LessonDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class GetLessonDetailEvent extends LessonDetailEvent{
  final int id;
  GetLessonDetailEvent({required this.id});
}

class SendHomeworkEvent extends LessonDetailEvent{
  final List<File> files;
  final String text;
  SendHomeworkEvent({required this.files, required this.text});
}

