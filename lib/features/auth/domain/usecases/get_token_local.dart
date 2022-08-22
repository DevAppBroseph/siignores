// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth/auth_repository.dart';

class GetTokenLocal implements UseCase<String?, NoParams> {
  final AuthRepository repository;

  GetTokenLocal(this.repository);

  @override
  Future<Either<Failure, String?>> call(NoParams params) async {
    return await repository.getTokenLocal();
  }
}
