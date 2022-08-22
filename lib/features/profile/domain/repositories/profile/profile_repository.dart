
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:siignores/core/error/failures.dart';

import '../../usecases/update_avatar.dart';
import '../../usecases/update_user_info.dart';

abstract class ProfileRepository {
  Future<Either<Failure, bool>> updateUserInfo(UpdateUserInfoParams params);
  Future<Either<Failure, bool>> updateAvatar(UpdateAvatarParams params);

}