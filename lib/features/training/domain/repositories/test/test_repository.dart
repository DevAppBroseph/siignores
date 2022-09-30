import 'package:dartz/dartz.dart';
import 'package:siignores/features/training/domain/entities/test_entity.dart';
import '../../../../../core/error/failures.dart';

abstract class TestRepository {
  Future<Either<Failure, TestEntity>> getTest(int params);
  Future<Either<Failure, bool>> sendAnswer(int params);
  Future<Either<Failure, Map<String, int>>> completeTest(int params);
}