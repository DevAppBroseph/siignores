// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth/auth_repository.dart';

class GetUserInfo implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  GetUserInfo(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.getUserInfo();
  }
}
