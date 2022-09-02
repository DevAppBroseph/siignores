// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth/auth_repository.dart';

class AuthSignIn implements UseCase<String, AuthSignParams> {
  final AuthRepository repository;

  AuthSignIn(this.repository);

  @override
  Future<Either<Failure, String>> call(AuthSignParams params) async {
    return await repository.authSignIn(params);
  }
}

class AuthSignParams extends Equatable {
  final String email;
  final String password;
  final String fcmToken;

  AuthSignParams({required this.email, required this.password, required this.fcmToken});

  @override
  List<Object> get props => [email, password];
}