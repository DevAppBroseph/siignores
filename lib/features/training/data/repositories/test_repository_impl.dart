// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:siignores/core/services/network/network_info.dart';
import 'package:siignores/features/training/domain/entities/course_entity.dart';
import 'package:siignores/features/training/domain/entities/lesson_list_entity.dart';
import 'package:siignores/features/training/domain/entities/test_entity.dart';
import 'package:siignores/features/training/domain/usecases/send_homework.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/lesson_detail_entity.dart';
import '../../domain/entities/module_enitiy.dart';
import '../../domain/repositories/test/test_repository.dart';
import '../datasources/test/remote_datasource.dart';


class TestRepositoryImpl implements TestRepository {
  final TestRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  TestRepositoryImpl(
      this.remoteDataSource, this.networkInfo);






  @override
  Future<Either<Failure, TestEntity>> getTest(params) async {
    if (await networkInfo.isConnected) {
      try {
        final items = await remoteDataSource.getTest(params);
        return Right(items);
      } catch (e) {
        print(e);
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }



  @override
  Future<Either<Failure, bool>> sendAnswer(params) async {
    if (await networkInfo.isConnected) {
      try {
        final items = await remoteDataSource.sendAnswer(params);
        return Right(items);
      } catch (e) {
        print(e);
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }




  @override
  Future<Either<Failure, Map<String, int>>> completeTest(params) async {
    if (await networkInfo.isConnected) {
      try {
        final items = await remoteDataSource.completeTest(params);
        return Right(items);
      } catch (e) {
        print(e);
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }


}

