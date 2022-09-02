import '../../domain/entities/progress_entity.dart';

class ProgressModel extends ProgressEntity{
  ProgressModel({
    required int courseId,
    required String courseName,
    required int allModules,
    required int completedModules,
    required int allLessons,
    required int completedLessons,
    required num verdict

  }) : super(
    completedLessons: completedLessons,
    allLessons: allLessons,
    courseId: courseId,
    courseName: courseName,
    completedModules: completedModules,
    allModules: allModules,
    verdict: verdict
  );

  factory ProgressModel.fromJson(Map<String, dynamic> json) => ProgressModel(
    courseId: json['course_id'] ?? 1,
    courseName: json['course_name'],
    allModules: json['all_modules'],
    completedModules: json['completed_modules'],
    allLessons: json['all_lessons'],
    completedLessons: json['completed_lessons'],
    verdict: json['verdict']
    
  );
}