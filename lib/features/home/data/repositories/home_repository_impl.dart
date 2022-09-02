import 'package:dartz/dartz.dart';
import 'package:siignores/core/services/network/network_info.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/calendar_entity.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/progress_entity.dart';
import '../../domain/repositories/home/home_repository.dart';
import '../datasources/home/remote_datasource.dart';


class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  HomeRepositoryImpl(
      this.remoteDataSource, this.networkInfo);





  @override
  Future<Either<Failure, List<CalendarEntity>>> getCalendar() async {
    if (await networkInfo.isConnected) {
      try {
        final items = await remoteDataSource.getCalendar();
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
  Future<Either<Failure, List<ProgressEntity>>> getProgress() async {
    if (await networkInfo.isConnected) {
      try {
        final items = await remoteDataSource.getProgress();
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
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    if (await networkInfo.isConnected) {
      try {
        final items = await remoteDataSource.getNotifications();
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

