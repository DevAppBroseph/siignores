import 'package:dartz/dartz.dart';
import 'package:siignores/features/training/domain/entities/course_entity.dart';
import 'package:siignores/features/training/domain/entities/lesson_detail_entity.dart';
import 'package:siignores/features/training/domain/entities/lesson_list_entity.dart';
import 'package:siignores/features/training/domain/usecases/send_homework.dart';

import '../../../../../core/error/failures.dart';
import '../../entities/module_enitiy.dart';

abstract class TrainingRepository {
  Future<Either<Failure, List<CourseEntity>>> getCourses();
  Future<Either<Failure, List<ModuleEntity>>> getModules(int params);
  Future<Either<Failure, List<LessonListEntity>>> getLessons(int params);
  Future<Either<Failure, LessonDetailEntity>> getLesson(int params);
  Future<Either<Failure, bool>> sendHomework(SendHomeworkParams params);

}