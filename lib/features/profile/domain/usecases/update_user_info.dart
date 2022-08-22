import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/profile/profile_repository.dart';

class UpdateUserInfo implements UseCase<bool, UpdateUserInfoParams> {
  final ProfileRepository repository;

  UpdateUserInfo(this.repository);

  @override
  Future<Either<Failure, bool>> call(UpdateUserInfoParams params) async {
    return await repository.updateUserInfo(params);
  }
}


class UpdateUserInfoParams extends Equatable {
  final String firstName;
  final String lastName;
  UpdateUserInfoParams({required this.firstName, required this.lastName});

  @override
  List<Object> get props => [firstName, lastName];
}