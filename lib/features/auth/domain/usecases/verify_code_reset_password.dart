// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/reset_data_enitiy.dart';
import '../repositories/auth/auth_repository.dart';

class VerifyCodeResetPassword implements UseCase<ResetDataEntity, VerifyCodeResetPasswordParams> {
  final AuthRepository repository;

  VerifyCodeResetPassword(this.repository);

  @override
  Future<Either<Failure, ResetDataEntity>> call(VerifyCodeResetPasswordParams params) async {
    return await repository.verifyCodeResetPassword(params);
  }
}

class VerifyCodeResetPasswordParams extends Equatable {
  final String email;
  final String code;

  VerifyCodeResetPasswordParams({required this.email, required this.code});

  @override
  List<Object> get props => [email, code];
}