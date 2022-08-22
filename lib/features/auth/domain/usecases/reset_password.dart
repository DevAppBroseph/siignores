// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/reset_data_enitiy.dart';
import '../repositories/auth/auth_repository.dart';

class ResetPassword implements UseCase<bool, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPassword(this.repository);

  @override
  Future<Either<Failure, bool>> call(ResetPasswordParams params) async {
    return await repository.resetPassword(params);
  }
}

class ResetPasswordParams extends Equatable {
  final ResetDataEntity resetDataEntity;
  final String password;

  ResetPasswordParams({required this.resetDataEntity, required this.password});

  @override
  List<Object> get props => [resetDataEntity, password];
}