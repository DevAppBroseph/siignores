import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/calendar_entity.dart';
import '../repositories/home/home_repository.dart';

class GetCalendar implements UseCase<List<CalendarEntity>, NoParams> {
  final HomeRepository repository;

  GetCalendar(this.repository);

  @override
  Future<Either<Failure, List<CalendarEntity>>> call(NoParams params) async {
    return await repository.getCalendar();
  }
}