import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/test/test_repository.dart';

class CompleteTest implements UseCase<Map<String, int>, int> {
  final TestRepository repository;

  CompleteTest(this.repository);

  @override
  Future<Either<Failure, Map<String, int>>> call(int params) async {
    return await repository.completeTest(params);
  }
}