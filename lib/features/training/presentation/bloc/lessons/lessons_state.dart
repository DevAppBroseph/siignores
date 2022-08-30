part of 'lessons_bloc.dart';

class LessonsState extends Equatable {
  const LessonsState();
  @override
  List<Object> get props => [];
}

class LessonsInitialState extends LessonsState {}
class LessonsLoadingState extends LessonsState {}
class LessonsErrorState extends LessonsState {
  final String message;
  LessonsErrorState({required this.message});
}
class LessonsInternetErrorState extends LessonsState{}

class GotSuccessLessonsState extends LessonsState{}
