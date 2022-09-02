import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/progress_entity.dart';
import '../repositories/home/home_repository.dart';

class GetProgress implements UseCase<List<ProgressEntity>, NoParams> {
  final HomeRepository repository;

  GetProgress(this.repository);

  @override
  Future<Either<Failure, List<ProgressEntity>>> call(NoParams params) async {
    return await repository.getProgress();
  }
}