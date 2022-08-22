// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth/auth_repository.dart';

class SendCodeResetPassword implements UseCase<bool, SendCodeResetPasswordParams> {
  final AuthRepository repository;

  SendCodeResetPassword(this.repository);

  @override
  Future<Either<Failure, bool>> call(SendCodeResetPasswordParams params) async {
    return await repository.sendCodeResetPassword(params);
  }
}

class SendCodeResetPasswordParams extends Equatable {
  final String email;

  SendCodeResetPasswordParams({required this.email});

  @override
  List<Object> get props => [email];
}