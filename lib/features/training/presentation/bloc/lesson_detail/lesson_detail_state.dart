part of 'lesson_detail_bloc.dart';

class LessonDetailState extends Equatable {
  const LessonDetailState();
  @override
  List<Object> get props => [];
}

class LessonDetailInitialState extends LessonDetailState {}
class LessonDetailLoadingState extends LessonDetailState {}
class LessonDetailErrorState extends LessonDetailState {
  final String message;
  LessonDetailErrorState({required this.message});
}
class LessonDetailInternetErrorState extends LessonDetailState{}

class GotSuccessLessonDetailState extends LessonDetailState{}
