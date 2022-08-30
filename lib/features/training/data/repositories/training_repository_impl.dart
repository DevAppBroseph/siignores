// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:siignores/core/services/network/network_info.dart';
import 'package:siignores/features/training/domain/entities/course_entity.dart';
import 'package:siignores/features/training/domain/entities/lesson_list_entity.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/lesson_detail_entity.dart';
import '../../domain/entities/module_enitiy.dart';
import '../../domain/repositories/training/training_repository.dart';
import '../datasources/training_main/remote_datasource.dart';


class TrainingRepositoryImpl implements TrainingRepository {
  final TrainingRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  TrainingRepositoryImpl(
      this.remoteDataSource, this.networkInfo);






  @override
  Future<Either<Failure, List<CourseEntity>>> getCourses() async {
    if (await networkInfo.isConnected) {
      try {
        final items = await remoteDataSource.getCourses();
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
  Future<Either<Failure, List<ModuleEntity>>> getModules(int params) async {
    if (await networkInfo.isConnected) {
      try {
        final items = await remoteDataSource.getModules(params);
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
  Future<Either<Failure, List<LessonListEntity>>> getLessons(int params) async {
    if (await networkInfo.isConnected) {
      try {
        final items = await remoteDataSource.getLessons(params);
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
  Future<Either<Failure, LessonDetailEntity>> getLesson(int params) async {
    if (await networkInfo.isConnected) {
      try {
        final item = await remoteDataSource.getLesson(params);
        return Right(item);
      } catch (e) {
        print(e);
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}

