// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:siignores/features/profile/domain/usecases/update_avatar.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/services/network/network_info.dart';
import '../../domain/repositories/profile/profile_repository.dart';
import '../../domain/usecases/update_user_info.dart';
import '../datasources/profile/remote_datasource.dart';


class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  ProfileRepositoryImpl(
      this.remoteDataSource, this.networkInfo);



  @override
  Future<Either<Failure, bool>> updateUserInfo(UpdateUserInfoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final item = await remoteDataSource.updateUserInfo(
          firstName: params.firstName,
          lastName: params.lastName,
        );
        return Right(item);
      } catch (e) {
        if(e is ServerException){
          return Left(ServerFailure(e.message!));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }



  @override
  Future<Either<Failure, bool>> updateAvatar(UpdateAvatarParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final item = await remoteDataSource.updateAvatar(params.file);
        return Right(item);
      } catch (e) {
        if(e is ServerException){
          return Left(ServerFailure(e.message!));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }



}

