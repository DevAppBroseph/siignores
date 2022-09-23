import 'package:dartz/dartz.dart';
import 'package:siignores/features/training/domain/entities/test_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/test/test_repository.dart';

class SendAnswerTest implements UseCase<bool, int> {
  final TestRepository repository;

  SendAnswerTest(this.repository);

  @override
  Future<Either<Failure, bool>> call(int params) async {
    return await repository.sendAnswer(params);
  }
}