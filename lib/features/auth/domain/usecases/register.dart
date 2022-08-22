// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth/auth_repository.dart';

class Register implements UseCase<bool, RegisterParams> {
  final AuthRepository repository;

  Register(this.repository);

  @override
  Future<Either<Failure, bool>> call(RegisterParams params) async {
    return await repository.register(params);
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String firstName;
  final String lastName;

  RegisterParams({required this.email, required this.firstName, required this.lastName});

  @override
  List<Object> get props => [email, firstName, lastName];
}