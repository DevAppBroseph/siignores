import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:siignores/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../repositories/profile/profile_repository.dart';

class UpdateAvatar implements UseCase<bool, UpdateAvatarParams> {
  final ProfileRepository repository;

  UpdateAvatar(this.repository);

  @override
  Future<Either<Failure, bool>> call(UpdateAvatarParams params) async {
    return await repository.updateAvatar(params);
  }
}

class UpdateAvatarParams extends Equatable {
  final File file;
  const UpdateAvatarParams({required this.file});

  @override
  List<Object> get props => [file];
}
