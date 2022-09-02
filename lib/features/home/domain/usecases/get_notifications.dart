import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/notification_entity.dart';
import '../repositories/home/home_repository.dart';

class GetNotifications implements UseCase<List<NotificationEntity>, NoParams> {
  final HomeRepository repository;

  GetNotifications(this.repository);

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(NoParams params) async {
    return await repository.getNotifications();
  }
}