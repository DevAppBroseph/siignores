import 'package:dartz/dartz.dart';
import 'package:siignores/features/training/domain/entities/course_entity.dart';
import 'package:siignores/features/training/domain/entities/module_entity.dart';

import '../../../../../core/error/failures.dart';

abstract class TrainingRepository {
  Future<Either<Failure, List<CourseEntity>>> getCourses();
  Future<Either<Failure, List<ModuleEntity>>> getModules(int params);

}