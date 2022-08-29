part of 'course_bloc.dart';

class CourseState extends Equatable {
  const CourseState();
  @override
  List<Object> get props => [];
}

class CourseInitialState extends CourseState {}
class CourseLoadingState extends CourseState {}
class CourseErrorState extends CourseState {
  final String message;
  CourseErrorState({required this.message});
}
class CourseInternetErrorState extends CourseState{}

class GotSuccessCourseState extends CourseState{}
