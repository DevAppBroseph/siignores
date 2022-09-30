import 'package:dartz/dartz.dart';
import 'package:siignores/features/training/domain/entities/test_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/test/test_repository.dart';

class GetTest implements UseCase<TestEntity, int> {
  final TestRepository repository;

  GetTest(this.repository);

  @override
  Future<Either<Failure, TestEntity>> call(int params) async {
    return await repository.getTest(params);
  }
}