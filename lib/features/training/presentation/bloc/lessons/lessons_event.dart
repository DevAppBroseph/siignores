part of 'lessons_bloc.dart';

class LessonsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class GetLessonsEvent extends LessonsEvent{
  final int id;
  GetLessonsEvent({required this.id});
}

