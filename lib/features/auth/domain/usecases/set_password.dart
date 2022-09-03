// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth/auth_repository.dart';

class SetPassword implements UseCase<String?, SetPasswordParams> {
  final AuthRepository repository;

  SetPassword(this.repository);

  @override
  Future<Either<Failure, String?>> call(SetPasswordParams params) async {
    return await repository.setPassword(params);
  }
}

class SetPasswordParams extends Equatable {
  final String email;
  final String password;
  final String fcmToken;

  SetPasswordParams({required this.email, required this.password, required this.fcmToken});

  @override
  List<Object> get props => [email, password];
}