// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth/auth_repository.dart';

class ActivationCode implements UseCase<bool, ActivationCodeParams> {
  final AuthRepository repository;

  ActivationCode(this.repository);

  @override
  Future<Either<Failure, bool>> call(ActivationCodeParams params) async {
    return await repository.activationCode(params);
  }
}

class ActivationCodeParams extends Equatable {
  final String email;
  final String code;

  const ActivationCodeParams({required this.email, required this.code});

  @override
  List<Object> get props => [email, code];
}
