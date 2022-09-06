// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:siignores/features/auth/domain/usecases/activation_code.dart';
import 'package:siignores/features/auth/domain/usecases/send_code_reset_password.dart';
import 'package:siignores/features/auth/domain/usecases/set_password.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/services/network/network_info.dart';
import '../../domain/entities/reset_data_enitiy.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth/auth_repository.dart';
import '../../domain/usecases/auth_signin.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/reset_password.dart';
import '../../domain/usecases/verify_code_reset_password.dart';
import '../datasources/auth/local_datasource.dart';
import '../datasources/auth/remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  final AuthenticationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  AuthRepositoryImpl(
      this.remoteDataSource, this.networkInfo, this.localDataSource);

  @override
  Future<Either<Failure, bool>> activationCode(
      ActivationCodeParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final isSent =
            await remoteDataSource.activationCode(params.email, params.code);
        return Right(isSent);
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure(e.message!));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> setPassword(SetPasswordParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await remoteDataSource.setPassword(
            params.email, params.password, params.fcmToken);
        if (token != null) {
          localDataSource.saveToken(token);
        }
        return Right(token);
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure(e.message!));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, String>> authSignIn(AuthSignParams params) async {
    if (await networkInfo.isConnected) {
      try {
        String token = await remoteDataSource.login(
            params.email, params.password, params.fcmToken);
        bool isSavedToken = await localDataSource.saveToken(token);
        if (isSavedToken) {
          return Right(token);
        } else {
          return Left(CacheFailure());
        }
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure(e.message!));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  /// Получение информации с бэка
  /// о покупателе(о user-е)
  @override
  Future<Either<Failure, UserEntity>> getUserInfo() async {
    if (await networkInfo.isConnected) {
      try {
        var userModel = await remoteDataSource.getUserInfo();
        return Right(userModel);
      } catch (e) {
        print(e);
        if (e is ServerException) {
          return Left(ServerFailure(e.message!));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> getTokenLocal() async {
    try {
      var token = await localDataSource.getToken();
      return Right(token);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      bool isDeletedToken = await localDataSource.deleteToken();
      remoteDataSource.logout();
      if (isDeletedToken) {
        return const Right(true);
      } else {
        return Left(CacheFailure());
      }
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> register(RegisterParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final isSent = await remoteDataSource.register(
          firstName: params.firstName,
          lastName: params.lastName,
          email: params.email,
          fcmToken: params.fcmToken,
        );
        return Right(isSent);
      } catch (e) {
        print(e);
        if (e is ServerException) {
          return Left(ServerFailure(e.message!));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  //Forgot password
  @override
  Future<Either<Failure, bool>> sendCodeResetPassword(
      SendCodeResetPasswordParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final isSent =
            await remoteDataSource.sendCodeForResetPassword(params.email);
        return Right(isSent);
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure(e.message!));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, ResetDataEntity>> verifyCodeResetPassword(
      VerifyCodeResetPasswordParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final verify = await remoteDataSource.verifyCodeForResetPassword(
            params.email, params.code);
        return Right(verify);
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure(e.message!));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> resetPassword(
      ResetPasswordParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final reset = await remoteDataSource.resetPassword(
            params.resetDataEntity, params.password);
        return Right(reset);
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure(e.message!));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAccount() async {
    if (await networkInfo.isConnected) {
      try {
        final isDeleted = await remoteDataSource.deleteAccount();
        return Right(isDeleted);
      } catch (e) {
        if (e is ServerException) {
          return Left(ServerFailure(e.message!));
        }
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
