import 'package:dartz/dartz.dart';
import 'package:siignores/features/training/domain/entities/lesson_detail_entity.dart';
import 'package:siignores/features/training/domain/entities/lesson_list_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/training/training_repository.dart';

class GetLesson implements UseCase<LessonDetailEntity, int> {
  final TrainingRepository repository;

  GetLesson(this.repository);

  @override
  Future<Either<Failure, LessonDetailEntity>> call(int params) async {
    return await repository.getLesson(params);
  }
}