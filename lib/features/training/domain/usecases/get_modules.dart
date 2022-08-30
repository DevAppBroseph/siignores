import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/module_enitiy.dart';
import '../repositories/training/training_repository.dart';

class GetModules implements UseCase<List<ModuleEntity>, int> {
  final TrainingRepository repository;

  GetModules(this.repository);

  @override
  Future<Either<Failure, List<ModuleEntity>>> call(int params) async {
    return await repository.getModules(params);
  }
}