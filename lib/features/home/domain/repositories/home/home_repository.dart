import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../entities/calendar_entity.dart';
import '../../entities/notification_entity.dart';
import '../../entities/progress_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<CalendarEntity>>> getCalendar();
  Future<Either<Failure, List<NotificationEntity>>> getNotifications();
  Future<Either<Failure, List<ProgressEntity>>> getProgress();
}