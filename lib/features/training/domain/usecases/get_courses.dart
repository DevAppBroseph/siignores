import 'package:dartz/dartz.dart';
import 'package:siignores/features/training/domain/entities/course_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/training/training_repository.dart';

class GetCourses implements UseCase<List<CourseEntity>, NoParams> {
  final TrainingRepository repository;

  GetCourses(this.repository);

  @override
  Future<Either<Failure, List<CourseEntity>>> call(NoParams params) async {
    return await repository.getCourses();
  }
}