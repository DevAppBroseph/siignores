import 'package:dartz/dartz.dart';
import 'package:siignores/features/training/domain/entities/lesson_list_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/training/training_repository.dart';

class GetLessons implements UseCase<List<LessonListEntity>, int> {
  final TrainingRepository repository;

  GetLessons(this.repository);

  @override
  Future<Either<Failure, List<LessonListEntity>>> call(int params) async {
    return await repository.getLessons(params);
  }
}