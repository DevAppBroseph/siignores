
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:siignores/features/auth/domain/usecases/activation_code.dart';
import 'package:siignores/features/auth/domain/usecases/reset_password.dart';
import 'package:siignores/features/auth/domain/usecases/send_code_reset_password.dart';
import 'package:siignores/features/auth/domain/usecases/set_password.dart';
import 'package:siignores/features/auth/domain/usecases/verify_code_reset_password.dart';

import '../../../../../core/error/failures.dart';
import '../../entities/reset_data_enitiy.dart';
import '../../entities/user_entity.dart';
import '../../usecases/auth_signin.dart';
import '../../usecases/register.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> activationCode(ActivationCodeParams params);
  Future<Either<Failure, bool>> register(RegisterParams params);
  Future<Either<Failure, String>> authSignIn(AuthSignParams params);
  Future<Either<Failure, UserEntity>> getUserInfo();
  Future<Either<Failure, String?>> getTokenLocal();

  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, bool>> deleteAccount();
  Future<Either<Failure, String?>> setPassword(SetPasswordParams params);

  //Forgot password
  Future<Either<Failure, bool>> sendCodeResetPassword(SendCodeResetPasswordParams params);
  Future<Either<Failure, ResetDataEntity>> verifyCodeResetPassword(VerifyCodeResetPasswordParams params);
  Future<Either<Failure, bool>> resetPassword(ResetPasswordParams params);
}