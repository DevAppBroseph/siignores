import 'package:equatable/equatable.dart';

class ProgressEntity extends Equatable {
  final int courseId;
  final String courseName;
  final int allModules;
  final int completedModules;
  final int allLessons;
  final int completedLessons;
  final num verdict;

  ProgressEntity({
    required this.courseId,
    required this.courseName,
    required this.allModules,
    required this.completedModules,
    required this.allLessons,
    required this.completedLessons,
    required this.verdict
  });



  @override
  List<Object> get props => [
      courseId,
      courseName
      ];
}
